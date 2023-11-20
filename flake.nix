{
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
  outputs = {
    self,
    nixpkgs-stable,
  }: {
    packages.x86_64-linux.node-ad23450bfd78cc56739fef6150f95fb9a4105c4b33affe529fc0b71884cb2e12 = nixpkgs-stable.legacyPackages.x86_64-linux.buildEnv {
      name = "node-ad23450bfd78cc56739fef6150f95fb9a4105c4b33affe529fc0b71884cb2e12";
      paths = [
        ./node-ad23450bfd78cc56739fef6150f95fb9a4105c4b33affe529fc0b71884cb2e12/out
      ];
    };
    packages.x86_64-linux.node-0e0984c83782aa1cd6d43637871e121619bd5ac26064121cb65ca2c34c4b52ca = nixpkgs-stable.legacyPackages.x86_64-linux.buildEnv {
      name = "node-0e0984c83782aa1cd6d43637871e121619bd5ac26064121cb65ca2c34c4b52ca";
      paths = [
        ./node-0e0984c83782aa1cd6d43637871e121619bd5ac26064121cb65ca2c34c4b52ca/out
      ];
    };
  };
}
