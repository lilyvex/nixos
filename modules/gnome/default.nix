{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.lily.gnome;
in {
  options.lily.gnome.enable = lib.mkEnableOption "activate gnome";
  config = lib.mkIf cfg.enable {
    services = {
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
