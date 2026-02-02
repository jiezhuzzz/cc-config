{pkgs, ...}: let
  apps = import ../apps;
  inherit (apps) gui prod dev;
in {
  home.packages = with pkgs; [
    # container
    orbstack
    (writeShellScriptBin "ssh-clean" (builtins.readFile ../scripts/ssh-clean.sh))
  ];

  imports = [
    ./shared.nix
    dev.colima
    gui.rio
    prod.ssh
    prod.zellij
    gui.espanso
    gui.zed
    gui.obsidian
    # gui.anki
    gui.vscode
    gui.ghostty
    prod.fish
    prod.starship
    prod.rclone
    prod.op
    # prod.himalaya
  ];
}
