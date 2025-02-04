{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/code/dotfiles";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;  # default shell on catalina
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  fonts.packages = [
    pkgs.monaspace
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  nixpkgs.config.allowUnfree = true;

  homebrew = {
    enable = true;

    casks = [
      "bartender"
      "brave-browser"
      "fantastical"
      "hammerspoon"
      "karabiner-elements"
      "obsidian"
      "raycast"
      "soundsource"
      "wezterm"
    ];

    # masApps = {
    #   "Drafts" = 1435957248;
    #   "Reeder" = 1529448980;
    #   "Things" = 904280696;
    #   "Timery" = 1425368544;
    # };
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      # AppleKeyboardUIMode = 3;
      "com.apple.keyboard.fnState" = true;
    };
  };
}
