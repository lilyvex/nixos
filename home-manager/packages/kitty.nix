{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.fira-code-nerdfont;
      size = 14;
    };
    settings = {
      window_padding_width = 4;
      background_opacity = "0.65";
      background_blur = 1;
    };
  };
}
