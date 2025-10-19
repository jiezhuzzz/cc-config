{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    settings = {
      window-padding-x = 10;
      cursor-style-blink = false;
      font-size = 16;
      clipboard-trim-trailing-spaces = true;
      mouse-hide-while-typing = true;
      # custom-shader = "shaders/cursor_blaze_tapered.glsl";
      # custom-shader = "shaders/matrix-cursor.glsl";
      # custom-shader = "shaders/cursor_frozen.glsl";
      custom-shader = "shaders/inside-the-matrix.glsl";
    };
  };
}
