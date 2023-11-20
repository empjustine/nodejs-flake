{
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
  #inputs.nodejs_12_10_0.url = "undefined";
  inputs.nodejs_14_15_4.url = "github:NixOS/nixpkgs/b76d44b9612b0f2117cbce00a9e9508f068c752e";
  inputs.nodejs_14_18_1.url = "github:NixOS/nixpkgs/33582b3ee1d3edbe331b455ed423bc97e3fb7498";
  inputs.nodejs_16_13_2.url = "github:NixOS/nixpkgs/98bb5b77c8c6666824a4c13d23befa1e07210ef1";
  inputs.nodejs_16_16_0.url = "github:NixOS/nixpkgs/6c6409e965a6c883677be7b9d87a95fab6c3472e";
  inputs.nodejs_18_16_0.url = "github:NixOS/nixpkgs/9356eead97d8d16956b0226d78f76bd66e06cb60";
  outputs = {
    self,
    nixpkgs-stable,
    ...
  } @ inputs: {
    packages.x86_64-linux.nodejs_14_15_4 = inputs.nodejs_14_15_4.legacyPackages.x86_64-linux.nodejs;
    packages.x86_64-linux.nodejs_14_18_1 = inputs.nodejs_14_18_1.legacyPackages.x86_64-linux.nodejs;
    packages.x86_64-linux.nodejs_16_13_2 = inputs.nodejs_16_13_2.legacyPackages.x86_64-linux.nodejs;
    packages.x86_64-linux.nodejs_16_16_0 = inputs.nodejs_16_16_0.legacyPackages.x86_64-linux.nodejs;
    packages.x86_64-linux.nodejs_18_16_0 = inputs.nodejs_18_16_0.legacyPackages.x86_64-linux.nodejs;
  };
}
