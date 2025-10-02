{
  services.transmission = {
    enable = true;
    openPeerPorts = true;
    settings = {
      download-dir = "/storage/transmission/downloads";
    };
  };
}
