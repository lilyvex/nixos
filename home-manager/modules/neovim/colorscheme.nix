{...}: {
  programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        flavour = "mocha";
        background = {
          light = "latte";
          dark = "mocha";
        };
        transparent_background = true;
        show_end_of_buffer = false;
        term_colors = false;
        dim_inactive = false;
        no_italic = false;
        no_bold = false;
        style = "night";
        styles = {
          comments.italic = true;
          conditionals.italic = true;
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
        # custom_highlights = {
        #   LineNr = { fg = "#a5adce"; };
        # };
      };
    };
  };
}
