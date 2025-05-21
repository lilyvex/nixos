{...}: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        icons_enabled = true;
        component_separators = {
          left = "|";
          right = "|";
        };
        section_separators = {
          left = "";
          right = "";
        };
        disabled_filetypes.statusline = ["NvimTree" "alpha"];
        disabled_filetypes.winbar = ["NvimTree" "alpha"];
        theme = null;
      };
    };
  };
}
