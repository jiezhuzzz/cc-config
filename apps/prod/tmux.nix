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
      # CPU plugin configuration
      set -gF status-right "#{E:@catppuccin_status_cpu}"
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

      # status bar
      set -g status-right-length 150
      set -g status-left-length 100
      set -g status-left ""

     set -ag status-right "#{E:@catppuccin_status_session}"

      # options
      set -g renumber-windows on
    '';
  };

  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"
    set -g @catppuccin_window_text " #W"
    set -g @catppuccin_window_current_text " #W"
  '';
}
