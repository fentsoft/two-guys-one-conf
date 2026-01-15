{
  lib,
  pkgs,
  ...
}: {
  environment.variables = {
    TUCKR_CUSTOM_TARGETS = "oskar";
  };

  my =
    {
      git = {
        userName = "vaaski";
        userEmail = "admin@vaa.ski";
      };

      ssh.authorizedKeys = [
        # atlas
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCn75kBDz7/E92HNrgITF1rGQvoKIL9kZfECCEgNKaCtoTxr10L/TO1Uvq8LZMdxL3HIYO6PGJKzuYIsfEvN7Bx/PG0FXU7QWge0H0j3jCjgWx5p7RPwH76omIIryz0V7Vt+xPFJeGykiW0qmuHl8zK/uxVtHN/cVW+ukmpQ6ztmnRJ9HrGiYIOuOfNgnVr7J6i7lYv8kL+0l7gmBABnMIQk+7cIntgd54jroAdvcPQpja8pO6uki5Eh9XJrAmo/nW9KTjRSx+DtxuQny5lh7jZlwmKZtkIyV6MgoeWopDDWl69BmCzbRDh8GpnkHlCP09WGi6XMFQSGgmOIOhokE+D"

        # i15p
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYlfzHsYEWnzrrdM4t8GC9uA8SIIvjtieZEmIbw/yNn"

        # work mac
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKoiophA8kvDCGunKUiRX91opLWPoNUi+LIsVv+bCmz2"

        # m2-air
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1Z1+udAEvwovjH5/0Mqzrg/iC10+A9KMl2rssjglLB"
      ];
    }
    // lib.optionalAttrs (pkgs.stdenv.hostPlatform.isDarwin) {
      homebrew = {
        taps = [
          "mhaeuser/mhaeuser" # battery toolkit
        ];
        casks = [
          "affinity"
          "android-platform-tools"
          "audacity"
          "balenaetcher"
          "bambu-studio"
          "battery-toolkit"
          "bentobox"
          "betterdisplay"
          "bettertouchtool"
          "blender"
          "bleunlock"
          "connectmenow"
          "darkmodebuddy"
          "dbeaver-community"
          "displaylink"
          "docker-desktop"
          "finicky"
          "helium-browser"
          "hoppscotch"
          "iina"
          "iterm2"
          "jordanbaird-ice@beta"
          "keepingyouawake"
          "keyboardcleantool"
          "mullvad-vpn"
          "naps2"
          "obs"
          "obsidian"
          "prismlauncher"
          "raspberry-pi-imager"
          "raycast"
          "readdle-spark"
          "rectangle-pro"
          "scroll-reverser"
          "spotify"
          "stats"
          "telegram-desktop"
          "the-unarchiver"
          "utm"
          "vesktop"
          "visual-studio-code"
          "whatsapp"
        ];
      };
    };
}
