{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./komodo.nix
  ];

  my.username = "p";
  networking.hostName = "mini7";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.firewall.enable = lib.mkForce true;

  environment.systemPackages = with pkgs; [
    caddy
    docker
    komodo
  ];

  boot.kernelParams = ["consoleblank=20"];

  system.stateVersion = "26.05";
}
