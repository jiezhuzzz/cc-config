{
  pkgs,
  username,
  homeDir,
  ...
}: let
  apps = import ../apps;
  inherit (apps) dev prod;
in {
  home.username = username;

  home.homeDirectory = homeDir;
  home.stateVersion = "25.11";

  home.preferXdgDirectories = true;
  xdg.enable = true;

  programs.home-manager.enable = true;
  catppuccin.enable = true;
  catppuccin.flavor = "frappe";

  # Server specific packages
  home.packages = with pkgs; [
    # utils
    fastfetch
    bat
    fd
    lazydocker
    bottom
    jaq
    ov
    ripgrep
    procs
    curlie
    scc
    unzip
    # languages
    uv
    quarto
    just
    devenv
    typst
    nodejs
    # LSP
    alejandra
    nil
    shfmt
    argc
    prek
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    prod.oh-my-posh
    dev.shpool
    dev.direnv
    prod.eza
    prod.zsh
    prod.tmux
    prod.yazi
    dev.git
    dev.delta
    dev.gitui
    prod.fzf
    dev.helix
    dev.jujutsu
    prod.zoxide
    # agents
    dev.claude
    dev.codex
    dev.gemini
  ];
}
