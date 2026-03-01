{
  security.pam.services.sudo_local.touchIdAuth = true;
  nix.enable = false;
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
