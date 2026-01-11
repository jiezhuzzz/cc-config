{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor.overrideAttrs (old: {doCheck = false;});
    extensions = ["nix" "toml" "typst" "dockerfile" "opencode" "typst"];
    extraPackages = with pkgs; [
      tinymist
      alejandra
    ];
    mutableUserKeymaps = false;
    mutableUserSettings = false;
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
      # Editor
      soft_wrap = "editor_width";
      autosave = "on_focus_change";
      use_smartcase_search = true;
      colorize_brackets = true;
      # Languages
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
        Python = {
          language_servers = ["ty" "basedpyright" "..."];
        };
      };
      # LSP
      lsp = {
        tinymist.settings = {
          exportPdf = "onSave";
        };
      };
      features = {
        edit_prediction_provider = "copilot";
      };
      # Agents
      agent = {
        commit_message_model = {
          provider = "openai";
          model = "gpt-5.2";
        };
      };
    };
  };
}
