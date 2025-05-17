{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.nvidia;
in {
  options.lily.nvidia.enable = lib.mkEnableOption "activate Nvidia GPU support";
  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];
    environment.systemPackages = with pkgs; [
      libva-utils
      nvidia-vaapi-driver
      nvtopPackages.nvidia
      pciutils
      vdpauinfo
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      cudaPackages.cutensor
    ];
    # environment.sessionVariables = lib.mkIf config.lily.wayland.enable {
    #   GBM_BACKEND = "nvidia-drm";
    #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #   __GL_GSYNC_ALLOWED = "1";
    # };
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
          nvidia-vaapi-driver
          ocl-icd
        ];
        extraPackages32 = with pkgs; [vaapiVdpau];
      };
      nvidia = {
        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
        # of just the bare essentials.
        powerManagement.enable = true;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
  };
}
