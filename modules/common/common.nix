{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.common;
in {
  options.lily.common.enable = lib.mkEnableOption "activate common";
  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.openssh.enable = false;
    programs.zsh.enable = true;
    environment.systemPackages = with pkgs; [
      git
      neovim
      toybox
      util-linux

      # encryption and filesystem
      cryptsetup
      age

      # network tools
      wget
      curl
      # FS-tools
      unzip
      gnutar
      xz
      bzip2
      p7zip

      netcat-gnu
      dnsutils
      fd
      file
      tree

      btrfs-progs
    ];
    environment.shells = with pkgs; [zsh];
  };
}
