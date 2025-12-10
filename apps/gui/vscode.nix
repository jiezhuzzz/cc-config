{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles = {
      default = {
        enableExtensionUpdateCheck = false;
        enableMcpIntegration = true;
        enableUpdateCheck = false;
        extensions = pkgs.nix4vscode.forVscode [
          # Nix
          "jnoortheen.nix-ide"
          # Python
          "ms-python.python"
          "ms-python.debugpy"
          "charliermarsh.ruff"
          # "astral-sh.ty"
          # Rust
          "rust-lang.rust-analyzer"
          # container
          "ms-azuretools.vscode-containers"
          "ms-vscode-remote.remote-containers"
          # agent
          "github.copilot"
          "anthropic.claude-code"
          "google.geminicodeassist"
          "openai.chatgpt"
          # other
          "ms-vscode-remote.remote-ssh"
        ];
        userMcp = {
        };
        userSettings = {
          "chat.mcp.gallery.enabled" = true;
          "files.autoSave" = "afterDelay";

          "search.showLineNumbers" = true;
          "search.smartCase" = true;

          # editor
          "editor.fontFamily" = "JetBrainsMonoNL Nerd Font Mono";
          "editor.fontSize" = 16;
          "editor.formatOnSave" = true;
          "editor.inlayHints.enabled" = "offUnlessPressed";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.foldingImportsByDefault" = true;
          "editor.showFoldingControls" = "always";
          "editor.stickyScroll.enabled" = true;

          # UI
          "window.commandCenter" = false;
          "explorer.compactFolders" = false;
          # "explorer.decorations.badges" = false;
          # "explorer.decorations.colors" = false;
          "explorer.sortOrder" = "type";
          "workbench.activityBar.location" = "top";

          "github.gitProtocol" = "ssh";

          # Python
          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = "explicit";
              "source.fixAll" = "explicit";
            };
          };
        };
      };
    };
  };
}
