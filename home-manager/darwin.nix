{pkgs, ...}: {
  home.packages = with pkgs; [
    container
  ];

  imports = [
    ./shared.nix
    # ../apps/ghostty.nix
    ../apps/rio.nix
    ../apps/ssh.nix
    ../apps/zellij.nix
    ../apps/espanso.nix
    ../apps/zed.nix
  ];
}
