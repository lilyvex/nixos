{...}: {
  programs.nixvim.plugins.neocord.enable = true;
  programs.nixvim.plugins.neocord.settings = {
    show_line_number = true;
  };
}
