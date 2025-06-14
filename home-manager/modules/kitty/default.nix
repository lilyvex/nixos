{
  config,
  lib,
  pkgs,
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
      themeFile = "tokyo_night_night";
      font = {
        name = "AtkynsonMono Nerd Font Mono";
        package = pkgs.nerd-fonts.atkynson-mono;
      };

      settings = {
        confirm_os_window_close = 0;
        window_padding_width = 0;
        background_opacity = "0.65";
        background_blur = 1;
        dynamic_background_opacity = "yes";
      };
    };
  };
}
