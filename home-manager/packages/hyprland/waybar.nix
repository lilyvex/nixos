{ ... }:

{
  programs.waybar = {
    enable = true;
    style = ''
    * {
      font-family: "FiraCode Nerd Font", sans-serif;
    }

    window#waybar {
      background-color: #1e1e2e;
      color: #cdd6f4;
      transition-property: background-color;
      transition-duration: 500ms;
      border: 1px solid transparent;
      border-radius: 0px 0px 20px 20px;
    }

    button {
      box-shadow: inset 0px -3px transparent;
    }

    button:hover {
      background: #181825;
    }

    #workspaces {
      background: #1e1e2e;
    }

    #workspaces button {
      padding: 5px;
      background-color: transparent;
      color: #cdd6f4;
    }

    #workspaces button:hover {
      background: #181825;
    }

    #workspaces button.active {
      background-color: #313244;
    }

    #workspaces button.urgent {
      background-color: #f9e2af;
    }

    #window,
    #pulseaudio,
    #network,
    #tray,
    #clock {
      background-color: #1e1e2e;
      color: #cdd6f4;
      padding: 0px 5px 0px 5px;
    }

    .modules-right {
      padding-right: 10px;
    }

    .modules-left {
      padding-left: 10px;
    }
    '';
    settings = {
      mainBar = {
        height = 30;
        width = 1920;
        spacing = 4;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" "pulseaudio" "network" "clock" ];

        "hyprland/window" = {
          icon = true;
          format = "{initialTitle}";
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
              headphone = " ";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" " " ];
          };
          on-click = "pavucontrol";
        };
      };
    };
  };
}
