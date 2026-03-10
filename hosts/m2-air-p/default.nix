{...}: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.defaults.CustomUserPreferences."NSGlobalDomain" = {
    NSColorSimulateHardwareAccent = null;
    NSColorSimulatedHardwareEnclosureNumber = null;
    AppleAccentColor = 6;
  };

  system.defaults.dock.persistent-apps = [
    "/Applications/Spark Desktop.app"
    "/Applications/Microsoft Teams.app"
    "/Applications/Microsoft Outlook.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/iTerm.app"
    "/Applications/Obsidian.app"
    "/Applications/Telegram Desktop.app"
    "/Applications/Spotify.app"
    "/Applications/BambuStudio.app"
    "/Applications/Zen.app"
  ];
}
