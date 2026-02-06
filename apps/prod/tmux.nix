{pkgs, ...}: let
  tmux-smooth-scroll = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-smooth-scroll";
    version = "unknown";
    src = pkgs.fetchFromGitHub {
      owner = "azorng";
      repo = "tmux-smooth-scroll";
      rev = "4c1232796235173f3e48031cbffe4a19773a957a";
      sha256 = "sha256-nTB0V/Xln8QJ95TB+hpIbuf0GwlBCU7CFQyzd0oWXw4=";
    };
    rtpFilePath = "smooth-scroll.tmux";
  };
  tmux-menus = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-menus";
    version = "2.2.33";
    src = pkgs.fetchFromGitHub {
      owner = "jaclu";
      repo = "tmux-menus";
      rev = "879f56df1b9703ac277fa16b9bbaf8705f2e6a1c";
      sha256 = "sha256-UPWsa7sFy6P3Jo3KFEvZrz4M4IVDhKI7T1LNAtWqTT4=";
    };
    rtpFilePath = "menus.tmux";
  };
in {
  programs.tmux = {
    enable = true;
    prefix = "`";
    clock24 = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    mouse = true;
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      tmux-floax
      {
        plugin = tmux-smooth-scroll;
        extraConfig = ''
          set -g @smooth_scroll_speed "5"
          set -g @smooth-scroll-mouse "true"
        '';
      }
      {
        plugin = tmux-menus;
        extraConfig = ''
          set -g @menus_use_cache 'No'
        '';
      }
      tmux-fzf
    ];
    extraConfig = ''
      # Disable automatic window renaming
      set-option -g automatic-rename off
      set-option -g allow-rename off

      # Configure CPU stats colors for Catppuccin
      set -g @cpu_low_fg_color "#{@thm_fg}"
      set -g @cpu_medium_fg_color "#{@thm_fg}"
      set -g @cpu_high_fg_color "#{@thm_crust}"
      set -g @cpu_low_bg_color "#{@thm_surface_0}"
      set -g @cpu_medium_bg_color "#{@thm_yellow}"
      set -g @cpu_high_bg_color "#{@thm_red}"

      # Configure RAM stats colors
      set -g @ram_low_fg_color "#{@thm_fg}"
      set -g @ram_medium_fg_color "#{@thm_fg}"
      set -g @ram_high_fg_color "#{@thm_crust}"
      set -g @ram_low_bg_color "#{@thm_surface_0}"
      set -g @ram_medium_bg_color "#{@thm_peach}"
      set -g @ram_high_bg_color "#{@thm_red}"

      # Configure CPU temp colors
      set -g @cpu_temp_low_fg_color "#{@thm_fg}"
      set -g @cpu_temp_medium_fg_color "#{@thm_fg}"
      set -g @cpu_temp_high_fg_color "#{@thm_crust}"
      set -g @cpu_temp_low_bg_color "#{@thm_surface_0}"
      set -g @cpu_temp_medium_bg_color "#{@thm_sky}"
      set -g @cpu_temp_high_bg_color "#{@thm_red}"
      set -g @cpu_temp_format "%2.0f°"

      # CPU/RAM/Temp plugin configuration
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

      # status bar
      set -g status-right-length 150
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"

      set -ag status-right "#[fg=#{@thm_blue},bg=#{@thm_surface_0}] 󰘚 #[fg=#{@thm_fg}]#{ram_percentage} "
      set -ag status-right "#[fg=#{@thm_peach},bg=#{@thm_surface_0}] 󰔏 #[fg=#{@thm_fg}]#{cpu_temp} "
      set -ag status-right "#{E:@catppuccin_status_session}"
      # set -ag status-right "#{E:@catppuccin_status_uptime}"

      # options
      set -g renumber-windows on
    '';
  };

  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"
  '';
}
