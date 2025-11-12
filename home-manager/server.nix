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
    (writeShellScriptBin "aflpp" (builtins.readFile ../scripts/aflpp.sh))
    (writeShellScriptBin "mx" (builtins.readFile ../scripts/multiplier.sh))
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shared.nix
    ../apps/oh-my-posh.nix
    ../apps/podman.nix
    ../apps/shpool.nix
    ../apps/op.nix
  ];
}
