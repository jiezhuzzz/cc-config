{
  services.transmission = {
    enable = true;
    openPeerPorts = true;
    openRPCPort = true;
    settings = {
      download-dir = "/storage/transmission/downloads";
      incomplete-dir = "/storage/transmission/incomplete";
      watch-dir = "/storage/transmission/watch";
    };
  };
}
