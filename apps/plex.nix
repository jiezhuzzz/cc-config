{
  services.plex = {
    enable = true;
    openFirewall = true;
    settings = {
      rpc-whitelist = "*";
    };
  };
  services.tautulli.enable = true;
}
