{
  config,
  lib,
  ...
}: let
  cfg = config.lily.waybar;
in {
  options.lily.waybar = {
    enable = lib.mkEnableOption "activate waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
