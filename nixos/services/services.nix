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
}
