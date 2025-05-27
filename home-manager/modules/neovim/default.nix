{
  pkgs,
  nixvim,
  config,
  lib,
  ...
}: let
  cfg = config.lily.neovim;
in {
  imports = [
    ./colorscheme.nix
    ./plugins
    ./keybinds.nix
  ];
  options.lily.neovim = {
    enable = lib.mkEnableOption "activate neovim";
  };
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      performance = {
        byteCompileLua.enable = true;
        combinePlugins = {};
      };

      extraConfigLua = ''
        vim.opt.fillchars:append({ eob = " " })
        vim.o.cmdheight=0 
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.expandtab = false;
        vim.opt.shiftwidth = 0;
        vim.opt.tabstop = 4;

        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "cpp", "c", "hpp", "h" },
          callback = function()
            vim.bo.expandtab = false
            vim.bo.shiftwidth = 0
            vim.bo.tabstop = 4
            vim.bo.softtabstop = 4
          end,
        })
      '';
    };
  };
}
