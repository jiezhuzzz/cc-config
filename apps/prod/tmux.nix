{
  pkgs,
  ...
}: {
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
      cpu
      tmux-fzf
      # nord
    ];
    extraConfig = ''
      # status bar
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"

      # windows button
      #set -g window-status-format "●"
      #set -g window-status-current-format "●"
      #set -g window-status-current-style "#{?window_zoomed_flag,fg=yellow,fg=magenta,nobold}"
      #set -g window-status-bell-style "fg=red,nobold"

      # options
      set -g renumber-windows on

      # pane borders
      # set -g pane-border-lines simple
    '';
  };

  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"
    set -g @catppuccin_status_modules_right "application cpu session uptime"
  '';
}
