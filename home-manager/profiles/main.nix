{pkgs, ...}: {
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  lily = {
    zsh.enable = true;
    git.enable = true;
  };
}
