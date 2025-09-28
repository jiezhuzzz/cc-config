let
  onePassPath = "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
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
      "*" = {
        compression = true;
        forwardAgent = true;
        identityAgent = "${onePassPath}";
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
