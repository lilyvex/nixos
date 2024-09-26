{ ... }:

{
  imports =
    [
      ./boot.nix
      ./pipewire.nix
      ./cups.nix
      ./firewall.nix
      ./libinput.nix
      ./networkmanager.nix
    ];

    services.flatpak.enable = true;
}
