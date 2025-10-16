{config, ...}: let
  homeDir = config.home.homeDirectory;
in {
  programs.onepassword-secrets = {
    enable = true;
    tokenFile = "${homeDir}/.op-token";
    secrets = {
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
