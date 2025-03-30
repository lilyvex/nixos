{
  config,
  lib,
  ...
}: let
  cfg = config.lily.ghostty;
in {
  options.lily.ghostty = {
    enable = lib.mkEnableOption "activate ghostty";
  };

  config = lib.mkIf cfg.enable {
    home.file.".config/ghostty/shaders" = {
      source = ./shaders;
      recursive = true;
    };
    programs.ghostty = {
      enable = true;

      settings = {
        background-blur-radius = 0;
        #theme = "dark:catppuccin-mocha,light:catppuccin-latte";
        window-theme = "dark";
        background-opacity = 0.75;
        minimum-contrast = 1.1;
        window-padding-x = 5;
        window-padding-y = 5;
        gtk-adwaita = false;
        gtk-titlebar = false;
        #       custom-shader = "shaders/crt.glsl";
        #      custom-shader = "shaders/glow.glsl";
        confirm-close-surface = false;
        custom-shader-animation = true;
      };
    };
  };
}
