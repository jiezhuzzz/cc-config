{pkgs, ...}: let
  apps = import ../apps;
  inherit (apps) prod;
in {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
    ];
  };
  home.packages = with pkgs; [
    impala
    bluetui
  ];

  imports = [
    ./shared.nix
    prod.oh-my-posh
  ];
}
