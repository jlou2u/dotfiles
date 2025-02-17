{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      stylix,
      home-manager,
      agenix,
    }:
    {
      nixosConfigurations."imac-i7" = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-hardware.nixosModules.apple-imac-14-2
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [ agenix.packages.x86_64-linux.agenix ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jlou2u = import ./hosts/imac/home.nix;
            };
          }
          agenix.nixosModules.default
          ./hosts/imac/configuration.nix
        ];
      };
    };
}
