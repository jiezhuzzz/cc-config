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
    klee
  ];

  imports = [
    ./shared.nix
    ../apps/podman.nix
  ];
}
