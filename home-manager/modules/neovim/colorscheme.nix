{...}: {
  programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
        show_end_of_buffer = false;
        term_colors = false;
        dim_inactive = false;
        no_italic = false;
        no_bold = false;
        style = "night";
        styles = {
          comments.italic = true;
          conditionals.italic = true;
          sidebars = "transparent";
          floats = "transparent";
          loops = null;
          functions = null;
          keywords = null;
          strings = null;
          variables = null;
          numbers = null;
          booleans = null;
          properties = null;
          types = null;
          operators = null;
        };
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          telescope = true;
          notify = false;
          mini = false;
        };
      };
    };
  };
}
