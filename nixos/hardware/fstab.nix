{ ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/afce32c1-67df-4324-aebb-a113b71317b9";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}
