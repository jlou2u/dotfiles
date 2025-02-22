{
  config,
  pkgs,
  lib,
  ...
}:

{
  users.users.ltp = {
    isNormalUser = true;
    home = "/home/ltp";
    description = "LTP";
    linger = true;
  };

  home-manager.users.ltp =
    { pkgs, ... }:
    {

      home.username = "ltp";
      home.homeDirectory = "/home/ltp";

      systemd.services.ltpService = {
        enable = true;
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        description = "LTP Main Service";
        serviceConfig = {
          ExecStart = "${pkgs.ltp}/bin/ltp";
          User = "ltp";
          WorkingDirectory = "/opt/ltp";
          Restart = "always";
        };
        timerConfig = {
          OnCalendar = "*-*-* 00:01:00";
          AccuracySec = "1min"; # allow to batch updates
          Persistent = true; # Run missed jobs if the system was down
        };
      };

      home.stateVersion = "24.11";
    };
}
