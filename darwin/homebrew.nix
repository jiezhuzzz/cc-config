{
  homebrew = {
    enable = true;
    casks = [
      "arc"
      "raycast"
      "balenaetcher"
      "cursor"
      "istat-menus"
      "kaleidoscope"
      "keka"
      "kekaexternalhelper"
      "iina"
      "lunar"
      "zen"
      "thebrowsercompany-dia"
      "zoom"
      "zotero"
      "homerow"
      "1password"
      "karabiner-elements"
      "pdf-expert"
      "adguard"
      "hazel"
      "nx-studio"
      "cleanshot"
      "figma"
      "plex"
      "wakatime"
      "rustdesk"
      "bambu-studio"
    ];
    masApps = {
      "WeChat" = 836500024;
      "CotEditor" = 1024640650;
      "Tampermonkey" = 6738342400;
      "Pixelmator Pro" = 1289583905;
      "Infuse" = 1136220934;
      "Amphetamine" = 937984704;
      # "Bear" = 1091189122;
      "Obsidian Web Clipper" = 6720708363;
      # "AdGuard for Safari" = 1440147259;
      "1Password for Safari" = 1569813296;
      "Momentum" = 1564329434;
      "Raycast Companion" = 6738274497;
      "SnippetsLab" = 1006087419;
      "Noir" = 1592917505;
      "Immersive Translate" = 6447957425;
      "CloudMounter" = 1130254674;
    };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };
}
