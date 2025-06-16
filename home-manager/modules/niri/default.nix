{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.niri;
in { 
  options.lily.niri = {
    enable = lib.mkEnableOption "activate niri";
  };

  config = lib.mkIf cfg.enable {
    home.file.".config/niri/config.kdl" = {
      source = ./config.kdl;
      recursive = false;
      force = true;
    };

    home.packages = with pkgs; [
      # Support Xorg applications
      xwayland-satellite
    ];
  };
}
