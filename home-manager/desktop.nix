{pkgs, ...}: {
  programs.kitty.enable = true;

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
    ];
  };
  home.packages = with pkgs; [
    codeql
    shpool
  ];

  imports = [
    ./shared.nix
    ../apps/ghostty.nix
  ];
}
