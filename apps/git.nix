{
  pkgs,
  lib,
  ...
}: {
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
    };
    ignores = [".DS_Store" ".direnv/" ".cache/"];
  };
}
