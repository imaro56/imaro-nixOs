{ pkgs, ... }:

let
  bluetoothScript = pkgs.writeShellScript "waybar-bluetooth" ''
    powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')
    if [ "$powered" != "yes" ]; then
      printf '{"text": "󰂲", "tooltip": "Bluetooth off", "class": "off"}\n'
      exit 0
    fi

    connected_device=$(bluetoothctl devices Connected 2>/dev/null | head -1 | cut -d' ' -f3-)
    if [ -n "$connected_device" ]; then
      printf '{"text": "󰂱", "tooltip": "Connected: %s", "class": "connected"}\n' "$connected_device"
    else
      printf '{"text": "󰂯", "tooltip": "Bluetooth on", "class": "on"}\n'
    fi
  '';
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 0;
        spacing = 0;
        margin-top = 4;
        margin-left = 6;
        margin-right = 6;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "custom/uair"
          "idle_inhibitor"
          "memory"
          "temperature"
          "hyprland/language"
          "network"
          "custom/bluetooth"
          "backlight"
          "wireplumber"
          "battery"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
          all-outputs = false;
          persistent-workspaces = {
            "eDP-2" = [ 1 2 ];
            "DP-3" = [ 3 4 5 6 7 8 ];
            "DP-4" = [ 9 10 ];
          };
        };

        clock = {
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃶 {:%A, %B %d  %H:%M}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };

        memory = {
          interval = 5;
          format = "  {percentage}%";
          tooltip-format = "{used:0.1f}G / {total:0.1f}G";
          on-click = "ghostty -e btop";
        };

        temperature = {
          hwmon-path-abs = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
          input-filename = "temp1_input";
          interval = 5;
          critical-threshold = 85;
          format = " {temperatureC}°C";
          format-critical = " {temperatureC}°C";
          tooltip-format = "CPU Temperature: {temperatureC}°C";
          on-click = "ghostty -e btop";
        };

        "hyprland/language" = {
          format = "󰌌 {}";
          format-en = "EN";
          format-uk = "UA";
        };

        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format-wifi = "{essid}\nSignal: {signalStrength}%\nIP: {ipaddr}";
          tooltip-format-ethernet = "{ifname}\nIP: {ipaddr}";
          tooltip-format-disconnected = "No connection";
          on-click = "networkmanager_dmenu";
        };

        "custom/bluetooth" = {
          exec = toString bluetoothScript;
          return-type = "json";
          interval = 5;
          on-click = "overskride";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          tooltip-format = "Brightness: {percent}%";
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 {volume}%";
          format-icons = [ "󰕿" "󰖀" "󰕾" ];
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        battery = {
          bat = "BAT0";
          adapter = "ADP0";
          interval = 30;
          design-capacity = false;
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-full = "󰁹 Full";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };
          tooltip-format = "{timeTo}\n{power:.1f}W";
          tooltip-format-charging = "Charging: {timeTo}\n{power:.1f}W";
          tooltip-format-full = "Full\nHealth: {health}%";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip-format-activated = "Idle inhibitor: on";
          tooltip-format-deactivated = "Idle inhibitor: off";
        };

        "custom/uair" = {
          exec = "uairctl fetch '{\"text\":\"󱎫 {name} {time}\",\"class\":\"{state}\",\"percentage\":{percent}}'";
          return-type = "json";
          interval = 1;
          tooltip = false;
          on-click = "uairctl toggle";
          on-click-middle = "uairctl prev";
          on-click-right = "uairctl next";
        };

        tray = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: transparent;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background-color: #1e1e2e;
        border: 1px solid #313244;
        border-radius: 12px;
        padding: 0 4px;
      }

      /* Workspaces */
      #workspaces button {
        color: #585b70;
        padding: 0 6px;
        margin: 4px 2px;
        border-radius: 8px;
        transition: color 0.2s ease, padding 0.2s ease;
      }

      #workspaces button.active {
        padding: 0 12px;
      }

      #workspaces button:hover {
        background-color: #313244;
        color: #cdd6f4;
      }

      /* 1-2: code/chat - blue */
      #workspaces button:nth-child(-n+2).active {
        color: #89b4fa;
      }

      /* 3-8: main work - mauve */
      #workspaces button:nth-child(n+3):nth-child(-n+8).active {
        color: #cba6f7;
      }

      /* 9-10: logs/misc - peach */
      #workspaces button:nth-child(n+9).active {
        color: #fab387;
      }

      /* Base module styling */
      #clock,
      #memory,
      #temperature,
      #language,
      #network,
      #custom-bluetooth,
      #custom-uair,
      #backlight,
      #wireplumber,
      #battery,
      #idle_inhibitor,
      #tray {
        padding: 0 8px;
        margin: 4px 0;
      }

      /* Clock */
      #clock {
        color: #f9e2af;
      }

      /* Memory */
      #memory {
        color: #89dceb;
      }

      /* Temperature */
      #temperature {
        color: #94e2d5;
      }

      #temperature.critical {
        color: #f38ba8;
      }

      /* Language */
      #language {
        color: #f5c2e7;
      }

      /* Network */
      #network {
        color: #94e2d5;
      }

      #network.disconnected {
        color: #585b70;
      }

      /* Bluetooth */
      #custom-bluetooth {
        color: #89b4fa;
      }

      #custom-bluetooth.off {
        color: #585b70;
      }

      /* Backlight */
      #backlight {
        color: #fab387;
      }

      /* Audio */
      #wireplumber {
        color: #74c7ec;
      }

      #wireplumber.muted {
        color: #585b70;
      }

      /* Battery */
      #battery {
        color: #a6e3a1;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
        animation: blink 0.5s steps(12) infinite alternate;
      }

      #battery.charging,
      #battery.plugged {
        color: #94e2d5;
      }

      #battery.full {
        color: #b4befe;
      }

      @keyframes blink {
        to {
          color: #1e1e2e;
          background-color: #f38ba8;
        }
      }

      /* Pomodoro timer */
      #custom-uair {
        color: #585b70;
      }

      #custom-uair.resumed {
        color: #f38ba8;
      }

      /* Idle inhibitor */
      #idle_inhibitor {
        color: #585b70;
      }

      #idle_inhibitor.activated {
        color: #f9e2af;
      }

      /* Tray */
      #tray {
        color: #cdd6f4;
      }

      /* Tooltip */
      tooltip {
        background-color: #1e1e2e;
        border: 1px solid #313244;
        border-radius: 10px;
      }

      tooltip label {
        color: #cdd6f4;
        padding: 4px;
      }
    '';
  };
}
