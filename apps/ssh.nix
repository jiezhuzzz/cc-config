let
  onePassPath = "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in {
  programs.ssh = {
    enable = true;
    compression = true;
    forwardAgent = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
    includes = [
      "./cc-config"
    ];
    matchBlocks = {
      "uchicago" = {
        hostname = "linux.cs.uchicago.edu";
        user = "jiezhu";
      };
      "goku" = {
        proxyJump = "uchicago";
        user = "jiezzz";
      };
      "vegeta" = {
        proxyJump = "uchicago";
        user = "jiezzz";
      };
    };
  };
}
