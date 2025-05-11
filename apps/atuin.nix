{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    daemon.enable = true;
    settings = {
      dialect = "us";
      sync.records = true;
    };
  };
}
