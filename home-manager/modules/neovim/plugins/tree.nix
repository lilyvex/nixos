{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    settings = {
      disableNetrw = true;
      hijackNetrw = true;
      diagnostics.enable = true;
      preferStartupRoot = false;
      syncRootWithCwd = true;
      view = {
        side = "right";
        width = 30;
      };
      renderer.groupEmpty = true;
      actions.openFile.resizeWindow = true;
      git.ignore = false;
    };
  };
}
