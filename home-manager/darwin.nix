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
    ../apps/rio.nix
    ../apps/ssh.nix
    ../apps/zellij.nix
    ../apps/espanso.nix
    ../apps/zed.nix
    ../apps/wezterm.nix
    ../apps/fish.nix
    ../apps/starship.nix
    ../apps/rclone.nix
    ../apps/op.nix
  ];
}
