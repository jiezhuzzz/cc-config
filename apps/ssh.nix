{
  lib,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      "./cc-config"
    ];
    matchBlocks =
      {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/github.private";
        };
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        "uchicago" = {
          hostname = "linux.cs.uchicago.edu";
          user = "jiezhu";
          identityFile = "~/.ssh/lab.private";
        };
        "goku vegeta" = {
          proxyJump = "uchicago";
          user = "jiezzz";
          identityFile = "~/.ssh/lab.private";
        };
        "192.5.86.* 192.5.87.*" = {
          user = "cc";
          identityFile = "~/.ssh/cc.private";
        };
        "192.168.1.*" = {
          identityFile = "~/.ssh/personal.private";
        };
        "*" = {
          compression = true;
          forwardAgent = true;
          remoteForwards = [
            {
              # pbcopy
              bind.port = 2224;
              host.address = "127.0.0.1";
              host.port = 2224;
            }
            {
              # pbpaste
              bind.port = 2225;
              host.address = "127.0.0.1";
              host.port = 2225;
            }
          ];
        };
      };
  };
}
