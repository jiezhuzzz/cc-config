{pkgs, ...}: {
  home.packages = with pkgs; [
    container
    kanata
  ];

  imports = [
    ./shared.nix
    ../apps/rio.nix
    ../apps/ssh.nix
    ../apps/zellij.nix
    ../apps/espanso.nix
    ../apps/zed.nix
    ../apps/wezterm.nix
    ../apps/fish.nix
    ../apps/starship.nix
  ];
}
