{pkgs, ...}: {
  programs.kitty.enable = true;
  #wayland.windowManager.hyprland.enable = true;
  imports = [
    ./shared.nix
    ../apps/ghostty.nix
    ../apps/zellij.nix
  ];
}
