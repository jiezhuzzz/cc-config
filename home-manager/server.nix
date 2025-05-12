{
  pkgs,
  username,
  homeDir,
  ...
}: {
  home.username = username;

  home.homeDirectory = homeDir;

  imports = [
    ./shared.nix
  ];
}
