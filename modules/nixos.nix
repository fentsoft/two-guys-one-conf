{config, ...}: {
  users.users.${config.my.username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  virtualisation.docker = {
    enable = true;

    daemon.settings = {
      "bip" = "10.255.0.1/24";
      "default-address-pools" = [
        {
          "base" = "10.10.0.0/16";
          "size" = 24;
        }
        {
          "base" = "10.11.0.0/16";
          "size" = 24;
        }
        {
          "base" = "10.12.0.0/16";
          "size" = 24;
        }
      ];
    };
  };
  programs.nix-ld.enable = true; # needed for vscode server
  security.sudo.wheelNeedsPassword = true; # passwordless sudo
  networking.firewall.enable = false;
  networking.firewall.allowPing = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.fail2ban.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.keyMap = "de";
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
}
