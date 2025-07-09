{
  pkgs,
  username,
  homeDir,
  ...
}: {
  home.username = username;

  home.homeDirectory = homeDir;

  # Server specific packages
  home.packages = with pkgs; [
    codeql
  ];

  imports = [
    ./shared.nix
    ../apps/podman.nix
  ];
}
