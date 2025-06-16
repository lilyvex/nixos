{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.niriswitcher;
in { 
  options.lily.niriswitcher = {
    enable = lib.mkEnableOption "activate niriswitcher";
  };

  config = lib.mkIf cfg.enable {
    programs.niriswitcher = {
      enable = true;
    };
  };
}
