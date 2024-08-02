{ pkgs, ... }:

{
  imports = [
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
    # Monitors
    monitor =HDMI-A-1,2560x1080@75,auto,1

    # Autostart
    exec = pkill waybar; sleep 0.5; waybar
    exec = pkill swaybg; sleep 0.5; swaybg
    exec = waypaper --restore

    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = NVD_BACKEND,direct

    # Input config
    input {
          kb_layout = us
          follow_mouse = 1
          sensitivity = 0
    }

    general {
            gaps_in = 5
            gaps_out = 10
            border_size = 2
            col.active_border = rgba(89b4faff) rgba(b4befeff) 45deg
            col.inactive_border = rgba(45475aff)
    }

    decoration {
               rounding = 10

               blur {
                    enabled = true
                    size = 15
                    passes = 1
                    new_optimizations = true
               }

               drop_shadow = true
               shadow_range = 4
               shadow_render_power = 3
               col.shadow = rgba(1e1e2ebb)
    }

    animations {
               enabled = true

    }

    cursor {
           no_hardware_cursors = true
    }

    $mainMod = SUPER

    bind = $mainMod, m, exit,
    bind = $mainMod, v, togglefloating,
    bind = $mainMod, q, killactive,
    bind = $mainMod, s, togglesplit,
    bind = $mainMod, f, fullscreen,
    bind = $mainMod, p, pin,

    bind =, Print, exec, grim - | wl-copy
    bind = SHIFT, Print, exec, grim -g "$(slurp)" - | wl-copy

    bind = $mainMod, r, exec, wofi --show drun --allow-images

    bind = $mainMod,Tab,cyclenext,
    bind = $mainMod,Tab,bringactivetotop,

    bind = $mainMod,e,exec,hyprlock

    bind = $mainMod, h, movefocus, l
    bind = $mainMod, j, movefocus, d
    bind = $mainMod, k, movefocus, u
    bind = $mainMod, l, movefocus, r

    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bindm = ALT, mouse:272, resizewindow
   '';
  };

  home.packages = with pkgs; [
     wofi
     waypaper
     swaybg
     waybar
     pavucontrol
     libsForQt5.qtstyleplugins
     libsForQt5.qt5ct
     kdePackages.qt6ct
     kdePackages.breeze
     breeze-gtk
     catppuccin
     grim
     slurp
     catppuccin-kvantum
     kdePackages.qtstyleplugin-kvantum
  ];

  catppuccin.flavor = "mocha";
}
