{
  programs.zellij = {
    enable = true;
    # enableFishIntegration = true;
    # enableZshIntegration = true;
    # attachExistingSession = true;
    # exitShellOnExit = true;
    settings = {
      keybinds = {
        tab = {
          "bind \"Shift Left\"" = {
            MoveTab = "Left";
          };
          "bind \"Shift Right\"" = {
            MoveTab = "Right";
          };
          "bind \"Shift h\"" = {
            MoveTab = "Left";
          };
          "bind \"Shift l\"" = {
            MoveTab = "Right";
          };
        };
      };
    };
  };
}
