{ ... }:

{
  services.dunst = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      global = {
        offset = "10x10";
        origin = "bottom-right";
        width = 300;
        height = 500;
      };
    };
  };
}
