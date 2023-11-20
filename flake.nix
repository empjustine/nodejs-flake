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
  };
}
