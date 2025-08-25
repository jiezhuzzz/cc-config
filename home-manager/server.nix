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
    shpool
    (writeShellScriptBin "aflpp" (builtins.readFile ../scripts/aflpp.sh))
    (writeShellScriptBin "mx" (builtins.readFile ../scripts/multiplier.sh))
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shared.nix
    ../apps/podman.nix
  ];
}
