{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # environment.variables = {
  #   # Point Emacs to the source controlled configuration files.
  #   EMACSLOADPATH = builtins.getEnv "HOME" + "/.dotfiles/home-manager/packages/doom-emacs";
  # };
}
