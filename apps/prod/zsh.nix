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
      # fzf-tab
      zhm_wrap_widget fzf-tab-complete zhm_fzf_tab_complete
      bindkey '^I' zhm_fzf_tab_complete

      # Wrap atuin widgets for helix mode compatibility
      zhm_wrap_widget _atuin_search_widget zhm_atuin_search
      bindkey '^R' zhm_atuin_search

      # Wrap up arrow for atuin history navigation
      zhm_wrap_widget _atuin_up_search_widget zhm_atuin_up_search
      bindkey '^[[A' zhm_atuin_up_search  # Up arrow
    '';
  };
}
