{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    erosanix.url = "github:emmanuelrosa/erosanix";
    agenix.url = "github:ryantm/agenix";
  };
  outputs =
    {
      self,
      nixpkgs,
      stylix,
      home-manager,
      erosanix,
      agenix,
    }:
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        modules = [
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jlou2u = import ./hosts/imac/home.nix;
              extraSpecialArgs = { inherit erosanix; };
            };
          }
          ./hosts/imac/configuration.nix
          agenix.nixosModules.default
        ];
      };
    };
}
