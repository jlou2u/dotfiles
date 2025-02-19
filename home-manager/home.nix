# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./alacritty.nix
    ./direnv.nix
    ./firefox.nix
    ./git.nix
    ./nvim.nix
    ./tmux.nix
  ];

  home = {
    username = "jlou2u";
    homeDirectory = "/home/jlou2u";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # steam
    devenv
    pre-commit
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
