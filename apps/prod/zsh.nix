{config, ...}: {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
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
    initContent = ''
      # Load environment variables from ~/.envs
      if [ -f ~/.envs ]; then
        set -a
        source ~/.envs
        set +a
      fi

      # fzf
      zhm_wrap_widget fzf-completion zhm_fzf_completion
      bindkey '^I' zhm_fzf_completion
      # # fzf history
      # zhm_wrap_widget fzf-history-widget zhm_fzf_history
      # bindkey '^R' zhm_fzf_history
      # fzf-tab
      zhm_wrap_widget fzf-tab-complete zhm_fzf_tab_complete
      bindkey '^I' zhm_fzf_tab_complete
    '';
  };
}
