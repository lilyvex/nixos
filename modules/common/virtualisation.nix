{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.lily.virtualisation;
in {
  options.lily.virtualisation = {
    enable = lib.mkEnableOption "activate virtualisation support";
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.groups.libvirtd.members = ["lily"];
  };
}
