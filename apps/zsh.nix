{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    antidote.enable = true;
    antidote.plugins = [
      "zsh-users/zsh-completions"
      "zsh-users/zsh-syntax-highlighting"
      "multirious/zsh-helix-mode"
      "Aloxaf/fzf-tab"
      "lipov3cz3k/zsh-uv"
    ];
  };
}
