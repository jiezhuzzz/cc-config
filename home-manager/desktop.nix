{pkgs, ...}: {
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
    ../apps/oh-my-posh.nix
  ];
}
