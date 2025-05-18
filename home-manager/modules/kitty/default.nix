{
  config,
  lib,
  ...
}: let
  cfg = config.lily.kitty;
in { 
  options.lily.kitty = {
    enable = lib.mkEnableOption "activate kitty";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";

      settings = {
        confirm_os_window_close = 0;
	window_padding_width = 5;
        background_opacity = "0.45";
        background_blur = 1;
        dynamic_background_opacity = "yes";
      };
    };
  };
}
