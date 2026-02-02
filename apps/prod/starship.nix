{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    settings = {
      c.disabled = true;
      python.disabled = true;
      golang.disabled = true;
    };
  };
}
