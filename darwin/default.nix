{pkgs, ...}
: {
  security.pam.services.sudo_local.touchIdAuth = true;
  nixpkgs = {
    config.allowUnfree = true;
    # hostPlatform = "aarch64-darwin";
  };
  imports = [
    ./system.nix
    ./fonts.nix
    ./homebrew.nix
    ../apps/aerospace.nix
    ../apps/_1password.nix
  ];
}
