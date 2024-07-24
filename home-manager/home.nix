{ config, pkgs, ... }:

{
  imports =
    [
      ./packages/packages.nix
    ];

  programs.home-manager.enable = true;

  home.username = "luxzi";
  home.homeDirectory = "/home/luxzi";
  home.stateVersion = "24.05";
}
