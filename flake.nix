{
  description = "Luxzi's NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }:
    let
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit self; };
          modules = [ ./nixos/configuration.nix catppuccin.nixosModules.catppuccin ];
        };
      };
      homeConfigurations = {
        luxzi = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/home.nix catppuccin.homeManagerModules.catppuccin ];
        };
      };
    };
}
