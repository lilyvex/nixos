{ pkgs, config, lib, ... }:
let
  cfg = config.lily.waybar;
in
{
  options.lily.waybar.enable = lib.mkEnableOption "activate waybar";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pavucontrol
      networkmanagerapplet
      blueman
    ];
    programs.waybar = {
      enable = true;
      style = ./style.css;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 40;
          # tray.icon-size = 15;

          modules-left = [
            "custom/icon"
            "custom/separator"
            "battery"
            "custom/separator"
            "custom/screenshot"
            "tray"
            "hyprland/workspaces"
          ];

          modules-center = [ "hyprland/window" ];
          modules-right = [
            "mpris"
            "pulseaudio"
            "network"
            "clock"
          ];

          mpris = {
            format = "{player_icon}{status_icon} <small><i>[{position}/{length}]</i></small> {title} - {artist}";
            tooltip-format = "{player_icon}{status_icon} [{position}/{length}] {title} - {artist}";
            title-len = 20;
            artist-len = 10;
            interval = 1;
            player-icons = {
              default = "";
              mpv = "🎵 ";
              spotify = " ";
            };
            status-icons = {
              playing = "▶";
              stopped = "󰓛";
              paused = "󰏤";
            };
            on-click-middle = "playerctld shift";
          };

          battery = {
            interval = 30;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}  {capacity}%";
            format-charging = "  {icon}  {capacity}%";
            format-icons = [ " " " " " " " " ];
            max-length = 25;
          };

          pulseaudio = {
            format = "{icon}  <b>{volume}</b>";
            format-bluetooth = " ";
            format-bluetooth-muted = " ";
            format-muted = "";
            format-icons = {
              default = [ "" "󰕾" "" ];
            };
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          };

          network = {
            format-wifi = "󰖩  {essid}";
            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
            format-ethernet = "󰈀  wired";
            format-disconnected = "";
            tooltip-format = "{ifname} via {gwaddr} ";
            tooltip-format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format-ethernet = "{ifname} ";
            tooltip-format-disconnected = "Disconnected";
          };

          clock = {
            format = "󰃰  {:%d.%m.%y 󰇙 %H:%M}";
          };

          "custom/icon" = {
            format = " ";
            # on-click = "${config.lily.wlogout.logoutlaunch}/bin/logoutlaunch";
          };

          "custom/screenshot" = {
            format = " ";
            on-click = "GRIM_DEFAULT_DIR=${config.xdg.configHome}/../Pictures/Screenshots ${pkgs.grim}/bin/grim";
          };

          "custom/separator" = {
            format = " ";
          };

          "hyprland/workspaces" = {
            format = "<span color=\"#b4befe\">{icon}</span>"; # lavender
            tooltip = false;
            all-outputs = false;
            current-only = true;
            sort-by-number = true;
            persistent-workspaces = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              "9" = "";
              "10" = "";
            };
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              "9" = "";
              "10" = "<span color=\"#74c7ec\">󰊠</span>"; # sapphire
              urgent = "<span color=\"#74c7ec\"></span>"; # sapphire
              active = "<span color=\"#89b4fa\">󰮯</span>"; # blue
              default = "";
            };
          };

          "hyprland/window" = {
            format = "{}";
            rewrite = {
              "" = "There is no place like ~";
            };
            max-length = 200;
            seperate-outputs = true;
          };
        };
      };
    };
    # home.file.".config/waybar/themes/theme.css" = { source = ./themes/Catppuccin-Mocha.css; };
  };
}
