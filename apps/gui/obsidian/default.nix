{
  programs.obsidian = {
    enable = true;
    vaults = {
      research = {
        enable = true;
        target = "Obsidian/research";
      };
    };
    # defaultSettings.communityPlugins = [
    #     linter = {
    #       enable = true;
    #       pkg = ./plugins/linter.nix;
    #     };
    # ];
  };
}
