{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.hyprland;
in {
  options.lily.hyprland = {
    enable = lib.mkEnableOption "activate hyprland";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    programs.kitty.enable = true; # required for the default Hyprland config
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        decoration = {
          rounding = 10;
          #         rounding_power = 2;
          blur = {
            enabled = true;
            size = 10;
            passes = 3;
            popups = true;

            xray = true;
          };
        };
        blurls = "waybar";
        dwindle = {
          pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # You probably want this
        };
        general = {
          resize_on_border = true; # Enables resizing by dragging window borders
          extend_border_grab_area = 15; # Extends the clickable area around the border for resizing
          hover_icon_on_border = true; # Shows a cursor icon when
          layout = "dwindle";
          "col.active_border" = "rgba(C55900ee) rgba(FFAA63ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          border_size = 2;
          gaps_out = 10;
        };
        exec-once = [
          "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init"
          "${pkgs.networkmanagerapplet}/bin/nm-applet"
          "${pkgs.blueman}/bin/blueman-applet"
        ];
        "$super" = "SUPER";
        "$alt_super" = "CTRL";

        bind = [
          "$super, Q, killactive"
          "$alt_super $super,Q,exit"
          # Screenshot region
          "$super SHIFT,S, exec, GRIM_DEFAULT_DIR=${config.home.homeDirectory}/Pictures/Screenshots/ ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy "
          "$super,T, exec, ghostty"
          "$super, L,exec, hyprlock --immediate"
          "$super, B,exec, chromium"
          "$super,F,fullscreen"
          "$super SHIFT,F,togglefloating"
          "$super,E,exec,kate"

          "ALT,SPACE,exec, rofi -show drun"
          "$super, P, pseudo,"

          "$super, 1, workspace, 1"
          "$super, 2, workspace, 2"
          "$super, 3, workspace, 3"
          "$super, 4, workspace, 4"
          "$super, 5, workspace, 5"
          "$super, 6, workspace, 6"
          "$super, 7, workspace, 7"
          "$super, 8, workspace, 8"
          "$super, 9, workspace, 9"
          "$super, 0, workspace, 10"

          # Move active window to a workspace iwth mainMod + SHIFT + j
          "$super SHIFT, 1, movetoworkspace, 1"
          "$super SHIFT, 2, movetoworkspace, 2"
          "$super SHIFT, 3, movetoworkspace, 3"
          "$super SHIFT, 4, movetoworkspace, 4"
          "$super SHIFT, 5, movetoworkspace, 5"
          "$super SHIFT, 6, movetoworkspace, 6"
          "$super SHIFT, 7, movetoworkspace, 7"
          "$super SHIFT, 8, movetoworkspace, 8"
          "$super SHIFT, 9, movetoworkspace, 9"
          "$super SHIFT, 0, movetoworkspace, 10"

          "$super, J, togglesplit"

          "$super, left, movefocus, l"
          "$super, right, movefocus, r"
          "$super, up, movefocus, u"
          "$super, down, movefocus, d"
        ];
        bindm = [
          "$super, mouse:272, movewindow"
          "$super, mouse:273, resizewindow"
        ];
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"
        ];
      };
    };
  };
}
