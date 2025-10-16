{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    settings = {
      window-padding-x = 10;
      font-size = 16;
      clipboard-trim-trailing-spaces = true;
      mouse-hide-while-typing = true;
    };
  };
}
