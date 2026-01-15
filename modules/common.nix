{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  userHome =
    if isDarwin
    then "/Users/${config.my.username}"
    else "/home/${config.my.username}";

  ytDlpUrl =
    if isDarwin
    then "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_macos"
    else "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_linux";

  ytDlpAuto = pkgs.writeShellScriptBin "yt-dlp" ''
    set -euo pipefail

    BIN="$HOME/.cache/yt-dlp/yt-dlp"
    MAX_AGE=$((48 * 60 * 60)) # 48 hours
    NOW=$(date +%s)

    stat_mtime() {
      stat -f %m "$1" 2>/dev/null || stat -c %Y "$1"
    }

    needs_update() {
      [ ! -x "$BIN" ] && return 0
      LAST=$(stat_mtime "$BIN")
      [ $((NOW - LAST)) -ge "$MAX_AGE" ]
    }

    if needs_update; then
      mkdir -p "$(dirname "$BIN")"
      curl -fL ${ytDlpUrl} -o "$BIN.tmp"
      chmod +x "$BIN.tmp"
      mv "$BIN.tmp" "$BIN"
    fi

    exec "$BIN" "$@"
  '';
in {
  options.my.username = lib.mkOption {
    type = lib.types.str;
    description = "Primary user name used across hosts/platforms.";
  };
  options.my.git = {
    userName = lib.mkOption {
      type = lib.types.str;
      description = "Git user.name to set for the primary user.";
    };
    userEmail = lib.mkOption {
      type = lib.types.str;
      description = "Git user.email to set for the primary user.";
    };
  };
  options.my.ssh = {
    authorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "SSH authorized keys for the primary user.";
    };
  };

  config = {
    my.username = lib.mkDefault "o";

    nix = {
      settings.experimental-features = "nix-command flakes";
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.my.username} = {
        home.stateVersion = "24.05";
        programs.git = {
          enable = true;
          settings = {
            gpg.format = "ssh";
            user.signingkey = "${userHome}/.ssh/id_ed25519.pub";
            commit.gpgsign = true;
            tag.gpgsign = true;
            user.name = config.my.git.userName;
            user.email = config.my.git.userEmail;
            pull.rebase = true;
          };
        };
      };
    };

    programs.zsh.enable = true;
    users.users.${config.my.username} = {
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = config.my.ssh.authorizedKeys;
    };

    environment.variables = {
      TUCKR_HOME =
        if isDarwin
        then "/etc/nix-darwin/dotfiles"
        else "/etc/nixos/dotfiles";
    };

    fonts.packages = [
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.jetbrains-mono
    ];

    environment.systemPackages = with pkgs; [
      age
      alejandra
      btop
      bun
      croc
      curl
      deno
      dust
      ffmpeg
      git
      go
      goreleaser
      gow
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nixd
      nodejs_24
      pnpm
      sops
      stow
      tree
      tuckr
      unzip
      wget
      zip

      ytDlpAuto
      nodePackages."@antfu/ni"
    ];
  };
}
