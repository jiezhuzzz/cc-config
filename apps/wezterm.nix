{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local config = wezterm.config_builder()

      config.font = wezterm.font("JetBrains Mono");
      config.font_size = 16.0;
      config.color_scheme = "Tomorrow Night";
      config.hide_tab_bar_if_only_one_tab = true;

      return config
    '';
  };
}
