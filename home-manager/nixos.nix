{pkgs, ...}: {
  programs.kitty.enable = true;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
    ];
  };

  #wayland.windowManager.hyprland.enable = true;
  imports = [
    ./shared.nix
    ../apps/ghostty.nix
    ../apps/zellij.nix
  ];
}
