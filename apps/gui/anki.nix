{pkgs, ...}: {
  programs.anki = {
    enable = true;
    theme = "followSystem";
    videoDriver = "metal";
    addons = with pkgs.ankiAddons; [
      review-heatmap
      anki-connect
    ];
    # ++ [
    #   (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
    #     pname = "recolor";
    #     version = "3.1";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "AnKing-VIP";
    #       repo = "AnkiRecolor";
    #       rev = finalAttrs.version;
    #       sparseCheckout = ["src/addon"];
    #       hash = "sha256-28DJq2l9DP8O6OsbNQCZ0pm4S6CQ3Yz0Vfvlj+iQw8Y=";
    #     };
    #     sourceRoot = "${finalAttrs.src.name}/src/addon";
    #   }))
    # ];
  };
}
