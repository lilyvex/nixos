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
      
      settings = {
        confirm_os_window_close = 0;
	window_padding_width = 5;
      };
    };
  };
}
