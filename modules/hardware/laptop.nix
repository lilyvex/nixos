{
  config,
  lib,
  ...
}: let
  cfg = config.lily.laptop;
in {
  options.lily.laptop.enable = lib.mkEnableOption "activate laptop hardware";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    powerManagement.enable = true;

    services = {
      libinput.enable = true;
    };
    systemd.sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=yes
      AllowHybridSleep=yes
      AllowSuspendThenHibernate=yes
    '';
  };
}
