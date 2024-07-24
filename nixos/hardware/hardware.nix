{ ... }:

{
  imports = 
    [
      ./modules.nix
      ./fstab.nix
      ./audio.nix
      ./network.nix
      ./intel.nix
      ./nvidia.nix
    ]; 
}
