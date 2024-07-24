{ ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6f9a4486-8f14-468f-aecb-5e0df8af2309";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4A4B-5B94";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}
