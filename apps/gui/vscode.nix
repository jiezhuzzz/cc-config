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
          "ms-python.vscode-pylance"
          # "astral-sh.ty"
          # Rust
          "rust-lang.rust-analyzer"
          # C/C++
          "ms-vscode.cpptools"
          "ms-vscode.cmake-tools"
          "llvm-vs-code-extensions.vscode-clangd"
          # config languages
          "redhat.vscode-yaml"
          "tamasfe.even-better-toml"
          # container
          "ms-azuretools.vscode-containers"
          "ms-vscode-remote.remote-containers"
          # agent
          "github.copilot"
          "github.copilot-chat"
          "anthropic.claude-code"
          "google.geminicodeassist"
          "openai.chatgpt"
          # other
          "ms-vscode-remote.remote-ssh"
          "github.codespaces"
          "github.vscode-github-actions"
          "mechatroner.rainbow-csv"
          "streetsidesoftware.code-spell-checker"
          # "wayou.vscode-todo-highlight"
        ];
        userMcp = {
        };
        userSettings = {
          "chat.mcp.gallery.enabled" = true;
          "files.autoSave" = "afterDelay";

          "search.showLineNumbers" = true;
          "search.smartCase" = true;

          # Editor
          "editor.fontFamily" = "JetBrainsMonoNL Nerd Font Mono";
          "editor.fontSize" = 16;
          "editor.formatOnSave" = true;
          "editor.inlayHints.enabled" = "offUnlessPressed";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.cursorBlinking" = "smooth";
          "editor.foldingImportsByDefault" = true;
          "editor.showFoldingControls" = "always";

          # UI
          "window.commandCenter" = false;
          "explorer.compactFolders" = false;
          "explorer.sortOrder" = "type";
          "workbench.activityBar.location" = "top";
          "workbench.panel.showLabels" = false;

          "github.gitProtocol" = "ssh";
          "git.confirmSync" = false;
          "git.autofetch" = true;

          # Zen Mode
          "zenMode.centerLayout" = false;
          "zenMode.fullScreen" = false;
          "zenMode.hideLineNumbers" = false;
          "zenMode.showTabs" = "none";

          # Python
          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = "explicit";
              "source.fixAll" = "explicit";
            };
          };
          # Nix
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "nix.serverSettings" = {
            "nil" = {
              "formatting" = {
                "command" = ["alejandra"];
              };
            };
          };
          # C/C++
          "C_Cpp.intelliSenseEngine" = "disabled";

          # Code Spell
          "cSpell.allowCompoundWords" = true;
          "cSpell.enabledFileTypes" = {
            "*" = true;
            "markdown" = true;
            "nix" = false;
          };

          "geminicodeassist.project" = "substantial-appliance-h2bpq";
        };
      };
    };
  };
}
