{
  # home.packages = with pkgs; [
  #   shpool
  # ];

  imports = [
    ./shared.nix
    ../apps/oh-my-posh.nix
  ];
}
