{
  lib,
  config,
  ...
}: let
  # Check if we're in a codespace environment
  isCodespace = config.home.username == "vscode";
in {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "jiezhuzzz";
        email = "jiezzz@duck.com";
      };
      aliases = {
        co = "checkout";
        cm = "commit -m";
        csm = "commit -s -m"; # DCO
        st = "status";
        br = "branch";
      };
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
    ignores = [".DS_Store" ".direnv/" ".cache/"];
    signing = lib.mkIf (!isCodespace) {
      format = "ssh";
      key = "~/.ssh/signing.private";
      signByDefault = true;
    };
  };
}
