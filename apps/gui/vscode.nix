{ pkgs, ... }:
{
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
          "kend.dancehelixkey"
          "mechatroner.rainbow-csv"
          "streetsidesoftware.code-spell-checker"
          "wayou.vscode-todo-highlight"
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
          # Nix
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "nix.formatterPath" = "alejandra";
          # C/C++
          "C_Cpp.intelliSenseEngine" = "disabled";
        };
      };
    };
  };
}
