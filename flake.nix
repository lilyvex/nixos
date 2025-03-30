{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.
    # Home manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    agenix.url = "github:ryantm/agenix";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    nixvim,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosModules = builtins.listToAttrs (
      (map (x: {
        name = x;
        value = import (./modules + "/${x}");
      }) (builtins.attrNames (builtins.readDir ./modules)))
      ++ [
        {
          name = "agenix";
          value = agenix.nixosModules.default;
        }
      ]
    );

    homeManagerModules =
      builtins.listToAttrs
      (
        map
        (name: {
          inherit name;
          value = import (./home-manager/modules + "/${name}");
        })
        (builtins.attrNames (builtins.readDir ./home-manager/modules))
      )
      // {
        nix = {pkgs, ...}: {
          imports = [
            inputs.nixvim.homeManagerModules.nixvim
            # inputs.plasma-manager.homeManagerModules.plasma-manager
            # inputs.wall-utils.homeManagerModules.wall-utils
          ];
        };
      };
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    #   GreenMachine = nixpkgs.lib.nixosSystem {
    #     specialArgs = {inherit inputs outputs;};
    #     modules = [
    #       # > Our main nixos configuration file <
    #       ./nixos/GreenMachine/configuration.nix
    #       agenix.nixosModules.default
    #     ];
    #   };
    # };
    nixosConfigurations =
      builtins.listToAttrs
      (
        map
        (x: {
          name = x;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              flake-self = self;
            };
            modules =
              builtins.attrValues self.nixosModules
              ++ [
                inputs.home-manager.nixosModules.home-manager
                inputs.nix-gaming.nixosModules.platformOptimizations
                inputs.nixvim.nixosModules.nixvim
                (import "${./.}/machines/${x}/configuration.nix" {inherit self;})
              ];
          };
        })
        (builtins.attrNames (builtins.readDir ./machines))
      );
    homeConfigurations = {
      lily = {...}: {
        imports =
          [
            ./home-manager/profiles/desktop.nix
          ]
          ++ builtins.attrValues self.homeManagerModules;
      };
    };
  };
}
