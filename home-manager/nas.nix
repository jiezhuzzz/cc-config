let
  apps = import ../apps;
  inherit (apps) prod;
in {
  # home.packages = with pkgs; [
  #   shpool
  # ];

  imports = [
    ./shared.nix
    prod.oh-my-posh
  ];
}
