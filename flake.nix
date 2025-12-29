{
  description = "vaaski's nixify-everything™ config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    mkDarwin = { system, host }:
      nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [
          ./modules/common.nix
          ./modules/darwin.nix
          ./hosts/${host}/default.nix
        ];
      };
  in
  {
    darwinConfigurations = {
      # sudo darwin-rebuild switch --flake ".#m2-air"
      m2-air = mkDarwin { system = "aarch64-darwin"; host = "m2-air"; };
    };
  };
}
