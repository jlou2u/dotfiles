{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption types;
  cfg = config.services.lt;
in
{
  options = {
    services.lt = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable the lt service.";
      };
    };
  };

  config = {
    systemd.services.lt = {
      description = "lt";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.lt}/bin/lt";
        Restart = "always";
        RestartSec = "10";
        User = "lt";
        Group = "lt";
        Environment = "LT_CONFIG=foobar";
      };
    };

    systemd.timers.lt = {
      description = "lt";
      wantedBy = [ "timers.target" ];
      after = [ "network.target" ];
      timerConfig = {
        OnCalendar = "*-*-* *:*:00";
        Unit = "lt.service";
      };
    };
  };

}
