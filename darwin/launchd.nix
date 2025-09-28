{config, ...}: {
  launchd.user.agents = {
    pbcopy.serviceConfig = {
      Label = "localhost.pbcopy";
      ProgramArguments = ["/usr/bin/pbcopy"];
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      ProcessType = "Background";
      # EnvironmentVariables = {"LC_CTYPE" = "UTF-8";};
      inetdCompatibility = {Wait = false;};
      Sockets.Listener = {
        SockServiceName = "2224";
        SockNodeName = "127.0.0.1";
      };
    };
    pbpaste.serviceConfig = {
      Label = "localhost.pbpaste";
      ProgramArguments = ["/usr/bin/pbpaste"];
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      ProcessType = "Background";
      inetdCompatibility = {Wait = false;};
      # EnvironmentVariables = {"LC_CTYPE" = "UTF-8";};
      Sockets.Listener = {
        SockServiceName = "2225";
        SockNodeName = "127.0.0.1";
      };
    };
  };
}
