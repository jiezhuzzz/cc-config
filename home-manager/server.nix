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
    argc
    (writeShellScriptBin "aflpp" (builtins.readFile ../scripts/aflpp.sh))
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shared.nix
    ../apps/podman.nix
  ];
}
