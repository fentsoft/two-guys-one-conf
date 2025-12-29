{ nixpkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "m2-air";
  networking.computerName = "m2-air";
  networking.localHostName = "m2-air";
}
