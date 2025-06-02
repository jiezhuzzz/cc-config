{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    attachExistingSession = true;
    exitShellOnExit = true;
    settings = {
      theme = "nord";
    }
  };
}
