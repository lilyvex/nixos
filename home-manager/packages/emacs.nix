{ pkgs, config, lib, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.activation = {
    cloneDoomEmacs = ''
        if [ ! -d "$HOME/.emacs.d" ]; then
            ${pkgs.git}/bin/git clone https://github.com/doomemacs/doomemacs $HOME/.emacs.d
        fi
      '';
  };

  home.file.".doom.d" = {
    source = ./doom-emacs/.doom.d;
    recursive = true;
    onChange = builtins.getEnv "HOME" + "/.emacs.d/bin/doom sync";
  };
}
