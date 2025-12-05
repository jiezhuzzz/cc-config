{
  pkgs,
  username,
  homeDir,
  ...
}: {
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
    ../apps/oh-my-posh.nix
    ../apps/shpool.nix
    ../apps/direnv.nix
    ../apps/eza.nix
    ../apps/zsh.nix
    ../apps/tmux.nix
    ../apps/yazi.nix
    ../apps/git.nix
    ../apps/delta.nix
    ../apps/gitui.nix
    ../apps/fzf.nix
    ../apps/helix.nix
    ../apps/jujutsu.nix
    ../apps/zoxide.nix
    # agents
    ../apps/claude.nix
    ../apps/codex.nix
    ../apps/gemini.nix
  ];
}
