{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "`";
    clock24 = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    mouse = true;
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      tmux-which-key
      tmux-fzf
    ];
    extraConfig = ''
      # status bar
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"

      set -agF status-right "#{E:@catppuccin_status_cpu}"
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"

      # options
      set -g renumber-windows on
    '';
  };

  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"
  '';
}
