{
  programs.obsidian = {
    enable = true;
    defaultSettings = {
      app = {
        promptDelete = false;
        showLineNumber = true;
        vimMode = false;
      };
      appearance = {
        showRibbon = false;
        showViewHeader = true;
        translucency = true;
      };
    };
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
