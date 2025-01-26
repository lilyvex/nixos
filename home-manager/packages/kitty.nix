{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
      size = 14;
    };
    settings = {
      window_padding_width = 4;
      background_opacity = "0.65";
      background_blur = 1;
    };
  };
}
