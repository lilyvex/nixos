{
  pkgs,
  lib,
  config,
  inputs,
  flake-self,
  ...
}: let
  cfg = config.lily.desktop;
in {
  options.lily.desktop = {
    enable = lib.mkEnableOption "activate desktop";
    plasma.enable = lib.mkEnableOption "activate plasma desktop environment";
    niri.enable = lib.mkEnableOption "activate niri desktop";
  };

  config = lib.mkIf cfg.enable {
    lily = {
      plasma.enable = cfg.plasma.enable;
      niri.enable = cfg.niri.enable;
    };
    programs = {
      dconf.enable = true;
      kdeconnect.enable = true;
    };
    environment.systemPackages = with pkgs; [
      vulkan-tools
      jq
      libqalculate
      envsubst
      glib
      headsetcontrol
      flatpak
      ntfs3g
    ];
    networking = {
      networkmanager.enable = true;
    };

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        jetbrains-mono
        noto-fonts-color-emoji
        garamond-libre
        helvetica-neue-lt-std
        # nerd-fonts.jetbrains-mono
      ];
      fontDir.enable = true;
      fontconfig = {
        defaultFonts = {
          monospace = ["JetBrainsMono Bold"];
          serif = ["Garamond Libre"];
          sansSerif = ["Helvetica Neue LT Std"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      audio.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # services.printing.enable = true;
    services.flatpak.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    services.udev.packages = [pkgs.headsetcontrol];
    # environment.sessionVariables = {
    #   MOZ_DISABLE_RDD_SANDBOX = "1";
    # };

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
  };
}
