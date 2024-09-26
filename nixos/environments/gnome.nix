{ ... }:

{
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    services.xserver.desktopManager.gnome.enable = true;
}
