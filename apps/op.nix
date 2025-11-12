{
  config,
  lib,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  programs.onepassword-secrets = {
    enable = true;
    tokenFile = "${homeDir}/.op-token";
    secrets =
      {
        signingPrivateKey = {
          reference = "op://Service/Signing/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/signing.private";
        };
        githubPrivateKey = {
          reference = "op://Service/GitHub/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/github.private";
        };
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        sshPrivateKey = {
          reference = "op://Service/Personal/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/personal.private";
        };
        labPrivateKey = {
          reference = "op://Service/Lab/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/lab.private";
        };
        ccPrivateKey = {
          reference = "op://Service/Chameleon/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/cc.private";
        };
      };
  };
}
