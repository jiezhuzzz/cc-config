{pkgs, ...}: {
  home.stateVersion = "25.11";

  home.preferXdgDirectories = true;
  xdg.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # utils
    fastfetch
    bat
    fd
    lazydocker
    podman-tui
    bottom
    jaq
    ripgrep
    procs
    curlie
    scc
    _1password-cli
    unzip
    # languages
    uv
    quarto
    typst
    nodejs
    # LSP
    alejandra
    nil
    shfmt
    argc
    codex
    (writeShellScriptBin "chameleon" (builtins.readFile ../scripts/chameleon.sh))
    (writeShellScriptBin "pbcopy" (builtins.readFile ../scripts/pbcopy.sh))
    (writeShellScriptBin "pbpaste" (builtins.readFile ../scripts/pbpaste.sh))
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    ZVM_INIT_MODE = "sourcing";
  };

  home.shellAliases = {
    g = "git";
    v = "nvim";
    vim = "nvim";
    vi = "nvim";
    ls = "eza";
    ll = "eza -l";
    la = "eza -la";
    tree = "eza --tree";
    lzd = "lazydocker";
    jq = "jaq";
    grep = "rg";
    # ssh = "TERM=xterm-256color ssh";
  };

  programs.home-manager.enable = true;
  catppuccin.enable = true;
  catppuccin.flavor = "frappe";

  imports = [
    ../apps/direnv.nix
    ../apps/eza.nix
    ../apps/zsh.nix
    ../apps/tmux.nix
    ../apps/yazi.nix
    ../apps/git.nix
    ../apps/gitui.nix
    ../apps/fzf.nix
    ../apps/helix.nix
    ../apps/jujutsu.nix
    ../apps/nixvim
    ../apps/rclone.nix
    ../apps/zoxide.nix
  ];
}
