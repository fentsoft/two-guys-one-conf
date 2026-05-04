{
  lib,
  pkgs,
  ...
}: {
  environment.variables = {
    TUCKR_CUSTOM_TARGETS = "paul";
  };

  # system.defaults.screencapture.target = lib.mkForce "clipboard";

  my =
    {
      git = {
        userName = "Snoilt";
        userEmail = "paul@oellers.net";
      };
      ssh.authorizedKeys = [
        #m4-pro
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwq7BEz4SXNwz5gAt9mtmNz6zGV/lJ8b9CUtxS/X7yb paul@oellers.net"

        #m2-air
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAANYKheY8aMzH8VDM2TbInbXgnAKU71TncoAFor0vwE paul@oellers.net"
      ];
    }

    // lib.optionalAttrs (pkgs.stdenv.hostPlatform.isDarwin) {
      homebrew = {
        taps = [
          "mhaeuser/mhaeuser" # battery toolkit
          "nikitabobko/aerospace" # aerospace app
        ];
        casks = [
          "aerospace"
          "audacity"
          "anaconda"
          "bambu-studio"
          "battery-toolkit"
          "betterdisplay"
          "blender"
          "codex"
          "codex-app"
          "dbeaver-community"
          "discord"
          "displaylink"
          "docker-desktop"
          "finicky"
          "google-chrome"
          "hoppscotch"
          "iterm2"
          "jordanbaird-ice@beta"
          "keepingyouawake"
          "leader-key"
          "mullvad-vpn"
          "miniconda"
          "obs"
          "obsidian"
          "prismlauncher"
          "raspberry-pi-imager"
          "raycast"
          "readdle-spark"
          "spotify"
          "stats"
          "steam"
          "telegram-desktop"
          "the-unarchiver"
          "utm"
          "visual-studio-code"
          "vlc"
          "zen"
        ];
      };
    };
}
