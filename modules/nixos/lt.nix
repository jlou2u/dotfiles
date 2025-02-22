{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  options.lt = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the LT service.";
    };

    repoPath = mkOption {
      type = types.str;
      default = "/opt/lt";
      description = "Path to the LT repository.";
    };

  };

  config = mkIf config.lt.enable {

    systemd.services.lt = {
      description = "lt main service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.lt.repoPath}/bin/lt";
        WorkingDirectory = config.lt.repoPath;
        User = "ltp";
      };
    };

    # Timer for the update service: fires daily at 00:00:05.
    systemd.timers.ltDailyTimer = {
      description = "Daily Timer for update a few seconds after midnight";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 00:00:05";
        AccuracySec = "1min";
        Persistent = true;
      };
      service = "lt.service";
    };
  };
}
