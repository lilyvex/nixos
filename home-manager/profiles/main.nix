{pkgs, ...}: {
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  lily = {
    zsh.enable = true;
    git.enable = true;
  };
}
