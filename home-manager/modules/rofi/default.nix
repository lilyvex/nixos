{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.rofi;
in {
  options.lily.rofi = {
    enable = lib.mkEnableOption "activate rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      package = pkgs.rofi-wayland;
      enable = true;
      plugins = [pkgs.rofi-calc];
    };

    home.file.".config/rofi" = {
      source = ./config;
      recursive = true;
      force = true;
    };
  };
}
