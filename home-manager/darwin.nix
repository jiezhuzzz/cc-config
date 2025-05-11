{
  pkgs,
  username,
  homeDir,
  ...
}: {
  imports = [
    ./shared.nix
  ];

  # Add Darwin-specific packages and configurations here
  home.packages = with pkgs; [
    # Darwin-specific packages
  ];
}
