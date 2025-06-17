{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.lily.niri;
in {
  options.lily.niri = {
    enable = lib.mkEnableOption "activate niri";
  };
  config = lib.mkIf cfg.enable {
    lily = {
      wayland.enable = true;
    };

    services.displayManager.sddm = lib.mkDefault {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "breeze";
      wayland.compositor = "kwin";
      extraPackages = with pkgs.kdePackages; [
        breeze-icons
        kirigami
        libplasma
        plasma5support
        qtsvg
        qtvirtualkeyboard
      ];
    };

    programs.niri.enable = true;
    services.blueman.enable = true;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    qt.enable = true;
    qt.platformTheme = "kde";

    environment.systemPackages = with pkgs; [
      # KDE APPLICATIONS
      kdePackages.dolphin
      kdePackages.systemsettings
      kdePackages.kalk
      kdePackages.merkuro

      kdePackages.qtwayland

      kdePackages.kwallet # provides helper service
      kdePackages.kwallet-pam # provides helper service
      kdePackages.kwalletmanager # provides KCMs and stuff

      # FRAMEWORKS AND BASES
      kdePackages.plasma-desktop
      kdePackages.plasma-workspace
      kdePackages.frameworkintegration # For qt plugins
      kdePackages.plasma-integration # kde platform theme
      kdePackages.sonnet
      kdePackages.libplasma
      kdePackages.qtsvg
      kdePackages.ksvg
      kdePackages.knewstuff
      kdePackages.kdeplasma-addons
      kdePackages.qtsvg
      kdePackages.qtdeclarative
      kdePackages.kcoreaddons
      kdePackages.kguiaddons
      kdePackages.kirigami-addons
      kdePackages.plasma-integration.qt5
      kdePackages.qtlocation

      # artwork, makes appliations which require org.kde.destkop work
      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.breeze-gtk
      kdePackages.ocean-sound-theme
      kdePackages.plasma-workspace-wallpapers
      hicolor-icon-theme # fallback icons
      kdePackages.qqc2-breeze-style
      kdePackages.qqc2-desktop-style

      kdePackages.breeze.qt5
      kdePackages.plasma-integration.qt5
      plasma5Packages.kwayland-integration
    ];
    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      KPACKAGE_DEP_RESOLVERS_PATH = "${pkgs.kdePackages.frameworkintegration.out}/libexec/kf6/kpackagehandlers";
    };
    services.udisks2.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    # make open menu work
    environment.etc."xdg/menus/applications.menu" = {
      source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
    #

    programs.ssh.askPassword = lib.mkDefault "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
    programs.gnupg.agent.pinentryPackage = lib.mkForce pkgs.pinentry-qt;
    security.pam.services = {
      login.kwallet = {
        enable = true;
        package = lib.mkDefault pkgs.kdePackages.kwallet-pam;
      };
    };

    programs.dconf.enable = true;

    programs.kdeconnect.package = lib.mkForce pkgs.kdePackages.kdeconnect-kde;
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      user.services.powerdevil = {
        description = "powerdevil";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.kdePackages.powerdevil}/libexec/org_kde_powerdevil";
        };
      };
    };
  };
}
