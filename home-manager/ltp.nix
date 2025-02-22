{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  home = {
    username = "ltp";
    homeDirectory = "/home/ltp";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    devenv
    eza
    fzf
    pre-commit
  ];
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  systemd.services.ltpService = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    description = "LTP Main Service";
    serviceConfig = {
      ExecStart = "ltp"; # "${pkgs.ltp}/bin/ltp";
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
}
