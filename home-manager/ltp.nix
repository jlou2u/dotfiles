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

  home.stateVersion = "24.11";
}
