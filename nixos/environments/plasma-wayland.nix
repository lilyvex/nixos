{ pkgs, ... }:

{
  services.xserver.videoDrivers = ["nvidia"];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs; [
    plasma-browser-integration
    konsole
  ];
}
