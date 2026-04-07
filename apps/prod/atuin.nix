{
  config,
  lib,
  ...
}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    daemon.enable = true;
    settings = {
      dialect = "us";
      sync.records = true;
    };
  };

  # Fix stale socket preventing daemon restart on macOS.
  # The upstream launchd agent lacks socket cleanup (unlike the systemd
  # version which uses RemoveOnStop). Wrap the command to remove any
  # leftover socket before starting.
  launchd.agents.atuin-daemon.config.ProgramArguments = lib.mkForce (let
    socketPath = "${config.xdg.dataHome}/atuin/daemon.sock";
    atuin = config.programs.atuin.package;
  in [
    "/bin/sh"
    "-c"
    "rm -f '${socketPath}' && exec ${atuin}/bin/atuin daemon"
  ]);
}
