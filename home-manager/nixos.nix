{pkgs, ...}: {
  imports = [
    ./shared.nix
    # ../apps/ghostty.nix
    ../apps/zellij.nix
  ];
}