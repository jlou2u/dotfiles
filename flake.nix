{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, stylix, home-manager }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      modules = [
        stylix.nixosModules.stylix
        ./hosts/imac/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jlou2u = import ./hosts/imac/home.nix;
        }
      ];
    };
  };
}
