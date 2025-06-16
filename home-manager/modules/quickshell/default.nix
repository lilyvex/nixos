{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.lily.quickshell;
in { 
  options.lily.quickshell = {
    enable = lib.mkEnableOption "activate quickshell";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.quickshell.packages."x86_64-linux".quickshell
    ];

    home.file.".config/quickshell" = {
      source = ./config;
      recursive = true;
      force = true;
    };
  };
}
