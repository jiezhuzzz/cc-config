{
  services.transmission = {
    enable = true;
    openPeerPorts = true;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      download-dir = "/storage/transmission/downloads";
      incomplete-dir = "/storage/transmission/incomplete";
      watch-dir = "/storage/transmission/watch";
    };
  };
}
