# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{...}: {
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  flake-self,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # inputs.home-manager.nixosModules.home-manager
    # inputs.nix-gaming.nixosModules.platformOptimizations

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    # ../common.nix
    # ./plymouth.nix
  ];
  lily = {
    users.lily.enable = true;
    common.enable = true;
    containers = {
      enable = true;
      docker = true;
    };
    nvidia.enable = true;
    desktop = {
      enable = true;
      hyprland.enable = true;
      plasma.enable = true;
    };
  };
  networking.hostName = "nix";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_lqx;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      platformOptimizations.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };

  home-manager = {
    users = {
      lily = flake-self.homeConfigurations.lily;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # system.stateVersion = "24.11";
}
