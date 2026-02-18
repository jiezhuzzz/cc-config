{
  pkgs,
  username,
  homeDir,
  ...
}: let
  apps = import ../apps;
  inherit (apps) dev prod;
in {
  home.username = username;

  # home.homeDirectory = homeDir;

  # Server specific packages
  home.packages = with pkgs; [
    codeql
    (writeShellScriptBin "aflpp" (builtins.readFile ../scripts/aflpp.sh))
    (writeShellScriptBin "mx" (builtins.readFile ../scripts/multiplier.sh))
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shared.nix
    prod.oh-my-posh
    dev.podman
    dev.shpool
    prod.op
    prod.ssh
    prod.atuin
  ];
}
