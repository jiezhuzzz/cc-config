{
  security.pam.services.sudo_local.touchIdAuth = true;
  nix.gc = {
    automatic = true;
    interval = [{Weekday = 2;}];
    options = "--delete-older-than 3d";
  };
  nix.settings.extra-experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.fish.enable = true;
  imports = [
    ./system.nix
    ./launchd.nix
    ./fonts.nix
    ./homebrew.nix
    ../apps/gui/aerospace.nix
  ];
}
