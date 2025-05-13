{pkgs, ...}: {
  imports = [
    ./shared.nix
    # ../apps/ghostty.nix
    ../apps/rio.nix
    ../apps/ssh.nix
    ../apps/zellij.nix
  ];
}
