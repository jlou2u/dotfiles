{
  description = "Example nix-darwin system flake";


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs }:
  let
    configuration = { pkgs, ... }: {

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
          pkgs.zsh
          pkgs.coreutils
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.users.justin = { pkgs, ... }: {
          home.packages = [ pkgs.atool pkgs.httpie ];
          programs.zsh.enable = true;

          # The state version is required and should stay at the version you
          # originally installed.
          home.stateVersion = "24.11";
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#justins-imac
    darwinConfigurations."justins-imac" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ 
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            users.justin = import ./home.nix;
          };
          users.users.justin.home = "/Users/justin";
        }
      ];
    };
    darwinConfigurations."justins-mbp" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            users.justin = import ./home.nix;
          };
          users.users.justin.home = "/Users/justin";
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
