{pkgs, ...}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
    ];
  };
  # home.packages = with pkgs; [

  # ];

  imports = [
    ./shared.nix
    ../apps/ghostty.nix
    ../apps/oh-my-posh.nix
  ];
}
