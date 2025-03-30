{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.lily.plasma;
in {
  options.lily.plasma.enable = lib.mkEnableOption "activate plasma";
  config = lib.mkIf cfg.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma6.enable = true;
    };
  };
}
