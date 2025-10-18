{
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "ruff" "dockerfile"];
    userSettings = {
      helix_mode = true;
      # UI
      buffer_font_size = 16;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_features.calt = false;
      terminal = {
        copy_on_select = true;
        cursor_shape = "bar";
        font_size = 12;
      };
      # editor
      soft_wrap = "editor_width";
      autosave = "on_focus_change";
      use_smartcase_search = true;
      # LSP
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
