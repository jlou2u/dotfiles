{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    erosanix.url = "github:emmanuelrosa/erosanix";
  };
  outputs = { self, nixpkgs, stylix, home-manager, erosanix }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      modules = [
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jlou2u = import ./hosts/imac/home.nix;
          home-manager.extraSpecialArgs = { inherit erosanix; };
        }
        ./hosts/imac/configuration.nix
      ];
    };
  };
}
