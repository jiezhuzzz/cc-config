{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.onepassword-secrets = {
    enable = true;
    tokenFile = "${config.home.homeDirectory}/.op-token";
    secrets =
      {
        signingPrivateKey = {
          reference = "op://SSH/Signing/private_key?ssh-format=openssh";
          path = ".ssh/signing.private";
          group =
            if pkgs.stdenv.isLinux
            then config.home.username
            else "staff";
        };
        githubPrivateKey = {
          reference = "op://SSH/GitHub/private_key?ssh-format=openssh";
          path = ".ssh/github.private";
          group =
            if pkgs.stdenv.isLinux
            then config.home.username
            else "staff";
        };
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        sshPrivateKey = {
          reference = "op://SSH/Personal/private_key?ssh-format=openssh";
          path = ".ssh/personal.private";
        };
        labPrivateKey = {
          reference = "op://SSH/Lab/private_key?ssh-format=openssh";
          path = ".ssh/lab.private";
        };
        ccPrivateKey = {
          reference = "op://SSH/Chameleon/private_key?ssh-format=openssh";
          path = ".ssh/cc.private";
        };
      };
  };
}
