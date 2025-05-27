# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./partition.nix
    ./fonts.nix
    ./graphic.nix
    ./audio.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "steamer";
  services.openssh = {
    enable = true;
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.vscode-server.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;
  programs.gamemode.enable = true;
  hardware.xone.enable = true;
  programs.niri.enable = true;
  #programs.hyprland.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.displayManager.autoLogin.enable = true;
  #services.displayManager.autoLogin.user = "jie";
  services.getty.autologinUser = "jie";

  # Pick only one of the below networking options.
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # services.xserver.desktopManager.gnome.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.jie = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxEzB8rb/S0bPaTymoXEj0OFj7FXy2XTapYXLJBMBkj"
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    protonup
    mangohud
    pavucontrol
  ];
  # environment.loginShellInit = ''
  #   [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
  # '';

  system.stateVersion = "24.11";
}
