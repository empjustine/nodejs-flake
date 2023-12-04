#!/usr/bin/env python3
import inspect
import json
import multiprocessing
import pathlib
import shlex
import subprocess


def main():
    download_packages = [
        "yarn",
        "pnpm",
        "npm",
    ]
    for package in download_packages:
        prefetch_files = []
        cmd = shlex.split(
            f"devbox run -- deno run -A npm:npm@latest show {package} versions --json",
        )
        process = subprocess.run(cmd, stdout=subprocess.PIPE)
        versions = [
            {"package": package, "version": version}
            for version in set(json.loads(process.stdout))
        ]
        with multiprocessing.Pool(12) as pool:
            for result in pool.imap_unordered(prefetch_npmjs, versions):
                prefetch_files.append(result)
        pathlib.Path(f"{package}.versions.json").write_text(json.dumps(prefetch_files))
    with pathlib.Path("flake.nix").open("w") as f:
        f.write(
            inspect.cleandoc(
                """
            {
              inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
              outputs = {
                self,
                nixpkgs,
                ...
              } @ inputs: {
            """,
            ),
        )
        f.write("\n")
        read_packages = [
            "yarn",
            "pnpm",
            "npm",
        ]
        for package in read_packages:
            for entry in json.loads(
                pathlib.Path(f"{package}.versions.json").read_text(encoding="utf8"),
            ):
                package = entry["package"]
                version = entry["version"]
                nix_version = "_".join(version.split("."))
                url = f"https://registry.npmjs.org/{package}/-/{package}-{version}.tgz"
                result = entry["result"]
                if result is not None:
                    nixHash = result["hash"]
                    for system in ["x86_64-linux"]:
                        string = (
                            ""
                            f"""    packages.{system}.nodePackages.{package}_{nix_version} = nixpkgs.legacyPackages.{system}.fetchurl {'{'}\n"""
                            f"""      url = "{url}";\n"""
                            f"""      hash = "{nixHash}";\n"""
                            f"""    {'}'};\n"""
                        )
                        f.write(string)
                        pkg_string = (
                            ""
                            f"""    packages.{system}.{package}_{nix_version} = derivation {'{'}\n"""
                            f"""      name = "{package}_{nix_version}";\n"""
                            f"""      system = "{system}";\n"""
                            f"""      builder = "${'{'}nixpkgs.legacyPackages.{system}.bash{'}'}/bin/bash";\n"""
                            f"""      args = [ ./npmjs_package_builder.sh ];\n"""
                            f"""      coreutils = nixpkgs.legacyPackages.{system}.coreutils;\n"""
                            f"""      findutils = nixpkgs.legacyPackages.{system}.findutils;\n"""
                            f"""      nodejs = nixpkgs.legacyPackages.{system}.nodejs_20;\n"""
                            f"""      package = self.packages.{system}.nodePackages.{package}_{nix_version};\n"""
                            f"""    {'}'};\n"""
                        )
                        f.write(pkg_string)
        f.write(
            inspect.cleandoc(
                """
                  };
                }
                """,
            ),
        )


def prefetch_npmjs(meta):
    package = meta["package"]
    version = meta["version"]
    url = f"https://registry.npmjs.org/{package}/-/{package}-{version}.tgz"
    print(url)
    cmd = shlex.split(
        f'nix --extra-experimental-features "nix-command flakes" store prefetch-file --json "{url}"',
    )
    process = subprocess.run(cmd, stdout=subprocess.PIPE, encoding="utf8")
    try:
        result = json.loads(process.stdout)
    except json.decoder.JSONDecodeError:
        result = None
    return {"package": package, "version": version, "result": result}


if __name__ == "__main__":
    main()
