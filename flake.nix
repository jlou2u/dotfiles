{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # stylix.url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561";
    stylix.url = "github:danth/stylix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        "imac-i7" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            vars = {
              username = "jlou2u";
            };
          };
          modules = [
            inputs.stylix.nixosModules.stylix
            inputs.agenix.nixosModules.default
            ./hosts/imac/configuration.nix
            inputs.home-manager.nixosModules.default
            { home-manager.extraSpecialArgs = { inherit inputs; }; }
          ];
        };
      };
    };
}
