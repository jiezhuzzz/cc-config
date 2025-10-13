{config, ...}: let
  homeDir = config.home.homeDirectory;
in {
  programs.onepassword-secrets = {
    enable = true;
    tokenFile = "${homeDir}/.secrets/op-token";
    secrets = {
      sshPrivateKey = {
        reference = "op://Service/Personal/private key";
        path = "${homeDir}/.ssh/id_rsa";
        mode = "0600";
      };
    };
  };
}
