{
  pkgs,
  username,
  homeDir,
  ...
}: {
  home.username = username;

  home.homeDirectory = homeDir;

  services.podman.enable = true;

  imports = [
    ./shared.nix
  ];
}
