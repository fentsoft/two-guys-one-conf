{
  description = "vaaski's nixify-everything™ config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    home-manager,
    nix-darwin,
    nix-homebrew,
    nixpkgs,
  }: let
    mkDarwin = {
      system,
      host,
      guy,
    }:
      nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {inherit self host guy inputs;};
        modules = [
          ./modules/tuckr.nix
          ./guys/${guy}/default.nix
          ./modules/common.nix
          ./modules/darwin.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          ./modules/homebrew.nix
          ./hosts/${host}/default.nix
        ];
      };

    mkNixos = {
      system,
      host,
      guy,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit self host guy inputs;};
        modules = [
          ./modules/tuckr.nix
          ./guys/${guy}/default.nix
          ./modules/common.nix
          ./modules/nixos.nix
          home-manager.nixosModules.home-manager
          ./hosts/${host}/default.nix
        ];
      };
  in {
    darwinConfigurations = {
      # sudo darwin-rebuild switch --flake ".#m2-air"
      m2-air = mkDarwin {
        system = "aarch64-darwin";
        host = "m2-air";
        guy = "oskar";
      };
      # sudo darwin-rebuild switch --flake ".#m3-pro"
      m3-pro = mkDarwin {
        system = "aarch64-darwin";
        host = "m3-pro";
        guy = "oskar";
      };
    };

    nixosConfigurations = {
      # sudo nixos-rebuild switch --flake ".#lserver"
      lserver = mkNixos {
        system = "x86_64-linux";
        host = "lserver";
        guy = "oskar";
      };
    };
  };
}
