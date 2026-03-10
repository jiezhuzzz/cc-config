{pkgs, ...}: let
  apps = import ../apps;
  inherit (apps) gui prod dev;
in {
  home.packages = with pkgs; [
    # container
    # orbstack
  ];

  imports = [
    ./shared.nix
    gui.rio
    prod.ssh
    prod.zellij
    # gui.espanso
    gui.zed
    gui.obsidian
    # gui.anki
    # gui.vscode
    gui.ghostty
    prod.fish
    prod.atuin
    prod.starship
    prod.rclone
    prod.op
    # prod.himalaya
  ];
}
