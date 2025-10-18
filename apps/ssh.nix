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
