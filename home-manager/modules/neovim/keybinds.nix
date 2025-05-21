{...}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      {
        mode = ["n" "v"];
        key = "<SPACE>";
        action = "<NOP>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<LEADER>,";
        action = "A,<ESC>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<LEADER>sf";
        action.__raw = "require('telescope.builtin').find_files";
        options = {
          silent = true;
          desc = "[S]earch [F]iles";
        };
      }
      {
        mode = "n";
        key = "<LEADER>tt";
        action.__raw = "require('nvim-tree.api').tree.toggle";
        options = {
          silent = true;
          desc = "[T]oggle [T]ree";
        };
      }
    ];
  };
}
