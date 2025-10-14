{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.emacs;
in {
  options.lily.emacs = {
    enable = lib.mkEnableOption "activate emacs";
  };

  config = lib.mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };
  };
}
