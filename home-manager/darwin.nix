{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    container
    kanata
    (writeShellScriptBin "ssh-clean" (builtins.readFile ../scripts/ssh-clean.sh))
  ];

  imports = [
    ./shared.nix
    ../apps/gui/rio.nix
    ../apps/ssh.nix
    ../apps/zellij.nix
    ../apps/gui/espanso.nix
    ../apps/gui/zed.nix
    ../apps/gui/wezterm.nix
    ../apps/gui/ghostty.nix
    ../apps/fish.nix
    ../apps/starship.nix
    ../apps/rclone.nix
    ../apps/op.nix
  ];
}
