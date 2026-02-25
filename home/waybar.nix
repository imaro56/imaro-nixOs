{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 8;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "battery" "pulseaudio" "tray" ];

        "hyprland/workspaces" = {
          format = "{id}";
          persistent-workspaces = {
            "*" = 10;
          };
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d  %H:%M}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          states = {
            warning = 30;
            critical = 15;
          };
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "  muted";
          format-icons.default = [ "" "" "" ];
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: #1e1e2e;
        color: #cdd6f4;
        border-bottom: 2px solid #313244;
      }

      #workspaces button {
        padding: 0 8px;
        color: #585b70;
        border-radius: 0;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        color: #89b4fa;
        border-bottom: 2px solid #89b4fa;
      }

      #workspaces button:hover {
        background: #313244;
        color: #cdd6f4;
      }

      #clock {
        color: #cdd6f4;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #pulseaudio {
        color: #89b4fa;
      }

      #pulseaudio.muted {
        color: #585b70;
      }

      #tray {
        color: #cdd6f4;
      }

      #clock,
      #battery,
      #pulseaudio,
      #tray {
        padding: 0 10px;
      }
    '';
  };
}
