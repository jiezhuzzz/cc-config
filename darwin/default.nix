{pkgs, ...}
: {
  security.pam.services.sudo_local.touchIdAuth = true;
  nixpkgs = {
    config.allowUnfree = true;
    # hostPlatform = "aarch64-darwin";
  };
  programs.fish.enable = true;
  imports = [
    ./system.nix
    ./launchd.nix
    ./fonts.nix
    ./homebrew.nix
    ../apps/aerospace.nix
  ];
}
