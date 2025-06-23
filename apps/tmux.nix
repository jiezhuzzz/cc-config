{
  config,
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
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      tmux-which-key
      # nord
    ];
    extraConfig = ''
      # status bar
      set -g status-style bg=default,fg=black,bright
      set -g status-left ""
      set -g status-right "#[fg=black,bright]#S"

      # windows button
      set -g window-status-format "●"
      set -g window-status-current-format "●"
      set -g window-status-current-style "#{?window_zoomed_flag,fg=yellow,fg=magenta,nobold}"
      set -g window-status-bell-style "fg=red,nobold"

      # options
      set -g renumber-windows on

      # pane borders
      set -g pane-border-lines simple
    '';
  };
}
