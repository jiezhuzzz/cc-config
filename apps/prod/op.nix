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
          reference = "op://SSH/Signing/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/signing.private";
          group =
            if pkgs.stdenv.isLinux
            then config.home.username
            else "staff";
        };
        githubPrivateKey = {
          reference = "op://SSH/GitHub/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/github.private";
          group =
            if pkgs.stdenv.isLinux
            then config.home.username
            else "staff";
        };
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        sshPrivateKey = {
          reference = "op://SSH/Personal/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/personal.private";
        };
        labPrivateKey = {
          reference = "op://SSH/Lab/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/lab.private";
        };
        ccPrivateKey = {
          reference = "op://SSH/Chameleon/private_key?ssh-format=openssh";
          path = "${homeDir}/.ssh/cc.private";
        };
      };
  };
}
