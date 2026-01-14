{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./komodo.nix
    ./raid.nix
    ./system-configuration.nix
  ];

  networking.hostName = "lserver";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  environment.systemPackages = with pkgs; [
    caddy
    docker
    komodo
    lm_sensors
    mdadm
  ];

  boot.kernelParams = ["consoleblank=20"];
  hardware.bluetooth.enable = true;

  system.stateVersion = "23.11";
}
