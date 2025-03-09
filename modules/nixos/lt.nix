{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkOption types;
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

  config = mkIf config.services.lt.enable {
    systemd.services.lt = {
      description = "lt";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ""; # "${pkgs.lt.outPath}/bin/lt";
        Restart = "always";
        RestartSec = "10";
        User = "ltp";
        Group = "users";
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
