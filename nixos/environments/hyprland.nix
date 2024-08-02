{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "Breeze";

  environment.variables.QT_QPA_PLATFORM = "wayland";
  environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";
  environment.variables.GTK_THEME = "Breeze";
}
