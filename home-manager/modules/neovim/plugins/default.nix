{...}: {
  imports = [
    ./telescope.nix
    ./lualine.nix
    ./treesitter.nix
    ./gitsigns.nix
    ./tree.nix
    ./lsp
    ./neocord.nix
    ./tmux-navigator.nix
    ./dashboard.nix
    ./which-key.nix
    #    ./dap.nix
  ];
  programs.nixvim.plugins = {
    sleuth.enable = true;
    comment.enable = true;
    indent-blankline.enable = true;
    web-devicons.enable = true;
    fugitive.enable = true;
    markdown-preview.enable = true;

    git-worktree = {
      enable = true;
      enableTelescope = true;
    };
  };
}
