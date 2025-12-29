{
  pkgs,
  lib,
  config,
  ...
}:
let
  ytDlpUrl =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_macos"
    else
      "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_linux";

  ytDlpAuto = pkgs.writeShellScriptBin "yt-dlp" ''
    set -euo pipefail

    BIN="$HOME/.cache/yt-dlp/yt-dlp"
    MAX_AGE=$((48 * 60 * 60))
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
in
{
  options.my.username = lib.mkOption {
    type = lib.types.str;
    description = "Primary user name used across hosts/platforms.";
  };

  config = {
    my.username = "o";

    nix.settings.experimental-features = "nix-command flakes";

    programs.zsh.enable = true;
    users.users.${config.my.username}.shell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
      btop
      bun
      croc
      curl
      deno
      dust
      ffmpeg
      fira-code
      git
      gnupg
      nixd
      nixfmt-rfc-style
      nodejs_24
      stow
      tree
      unzip
      wget
      zip

      ytDlpAuto
    ];
  };
}
