{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          format-wifi = "{signalStrength}%";
          format-ethernet = "ETH";
          format-disconnected = "OFF";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{volume}%";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        tray = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: monospace;
        font-size: 13px;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 5px;
        color: #cdd6f4;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        color: #b4befe;
        border-bottom: 2px solid #b4befe;
      }

      #clock, #battery, #network, #pulseaudio, #tray {
        padding: 0 10px;
      }
    '';
  };
}
