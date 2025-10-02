{pkgs, ...}: {
  home.packages = with pkgs; [
    shpool
  ];

  imports = [
    ./shared.nix
  ];
}
