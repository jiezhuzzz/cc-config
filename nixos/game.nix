{pkgs, ...}: {
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      mangohud
      gamescope-wsi
    ];
    gamescopeSession.enable = true;
    gamescopeSession.args = [
      "-w 3840"
      "-h 2160"
      "-r 120"
      "--xwayland-count 2"
      "-e"
      "--hdr-enabled"
      "--mangoapp"
    ];
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  hardware.xone.enable = true;
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
