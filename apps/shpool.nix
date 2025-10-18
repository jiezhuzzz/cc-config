{
  services.shpool = {
    enable = true;
    settings = {
      prompt_prefix = "[$SHPOOL_SESSION_NAME]";
      keybinding = [
        {
          action = "detach";
          binding = "Ctrl-b d";
        }
      ];
    };
  };
}
