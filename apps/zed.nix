{
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "ruff" "dockerfile"];
    userSettings = {
      helix_mode = true;
      buffer_font_size = 16;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_features.calt = false;
      terminal.font_size = 12;
      soft_wrap = "editor_width";
      languages = {
        Nix = {
          language_servers = ["nil" "!nixd" "..."];
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
      };
    };
  };
}
