{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    antidote.enable = true;
    antidote.plugins = [
      "zsh-users/zsh-completions"
      "zsh-users/zsh-syntax-highlighting"
      "jeffreytse/zsh-vi-mode"
      "Aloxaf/fzf-tab"
      "lipov3cz3k/zsh-uv"
    ];
    initContent = builtins.readFile ../scripts/aflpp.sh;
  };
}
