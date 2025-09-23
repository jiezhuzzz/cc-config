{config, ...}: {
  launchd.agents = {
    pbcopy.serviceConfig = {
      Label = "localhost.pbcopy";
      ProgramArguments = ["/usr/bin/pbcopy"];
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      ProcessType = "Background";
      inetdCompatibility = {Wait = false;};
      Sockets = {
        Listener = {
          SockServiceName = "2224";
          SockNodeName = "127.0.0.1";
        };
      };
    };
    pbpaste.serviceConfig = {
      Label = "localhost.pbpaste";
      ProgramArguments = ["/usr/bin/pbpaste"];
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      ProcessType = "Background";
      inetdCompatibility = {Wait = false;};
      Sockets = {
        Listener = {
          SockServiceName = "2225";
          SockNodeName = "127.0.0.1";
        };
      };
    };
  };
}
