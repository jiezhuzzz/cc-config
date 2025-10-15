{
  homebrew = {
    enable = true;
    casks = [
      "obsidian"
      "arc"
      "raycast"
      "balenaetcher"
      "cursor"
      "hazeover"
      "istat-menus"
      "kaleidoscope"
      "keka"
      "kekaexternalhelper"
      "iina"
      "lunar"
      "zen"
      "zoom"
      "zotero"
      "homerow"
      "1password"
      "karabiner-elements"
      # "bartender"
      "ghostty"
      "pronotes"
      "visual-studio-code"
      "pika"
      "pdf-expert"
      "adguard"
      "hazel"
      "openinterminal"
      "nx-studio"
      "notion"
      "notion-calendar"
      "notion-mail"
      "spotify"
      "cleanshot"
      "figma"
      "plex"
    ];
    masApps = {
      "WeChat" = 836500024;
      "CotEditor" = 1024640650;
      "Tampermonkey" = 6738342400;
      "Pixelmator Pro" = 1289583905;
      "Infuse" = 1136220934;
      "Amphetamine" = 937984704;
      # "Endel" = 1346247457;
      # "Bear" = 1091189122;
      "Obsidian Web Clipper" = 6720708363;
      # "AdGuard for Safari" = 1440147259;
      "1Password for Safari" = 1569813296;
      "Momentum" = 1564329434;
      "Raycast Companion" = 6738274497;
      "SnippetsLab" = 1006087419;
      "Noir" = 1592917505;
      "Immersive Translate" = 6447957425;
      "Affinity Designer 2" = 1616831348;
      "Affinity Photo 2" = 1616822987;
      "Affinity Publisher 2" = 1606941598;
      "CloudMounter" = 1130254674;
      # "TypeIt4Me 7" = 6474688391;
    };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };
}
