{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.alacritty
      pkgs.fzf
      pkgs.nix-output-monitor
      pkgs.tmux
      pkgs.tree
      pkgs.vim
      pkgs.wget
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  nix.configureBuildUsers = true;

  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "obelisk-docker-nix-builder";
    sshUser = "root";
    sshKey = "/Users/justin/.ssh/id_rsa";
    systems = ["x86_64-linux" "i686-linux"];
    maxJobs = 2;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
  }
];
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.substituters = [ "https://nixcache.reflex-frp.org" ];
  nix.settings.trusted-public-keys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Lewis Acquisitions";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
