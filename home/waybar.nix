{ pkgs, ... }:

let
  sysmonScript = pkgs.writeShellScript "waybar-sysmon" ''
    STATE_FILE="/tmp/waybar-sysmon-state"
    [ -f "$STATE_FILE" ] || echo 0 > "$STATE_FILE"
    STATE=$(cat "$STATE_FILE")

    case "$STATE" in
      0)
        read -r cpu_a1 idle_a1 <<< "$(awk '/^cpu / {print $2+$3+$4+$5+$6+$7+$8, $5+$6}' /proc/stat)"
        sleep 1
        read -r cpu_a2 idle_a2 <<< "$(awk '/^cpu / {print $2+$3+$4+$5+$6+$7+$8, $5+$6}' /proc/stat)"
        total=$((cpu_a2 - cpu_a1))
        idle=$((idle_a2 - idle_a1))
        if [ "$total" -gt 0 ]; then
          usage=$(( (total - idle) * 100 / total ))
        else
          usage=0
        fi
        printf '{"text": "CPU %s%%", "tooltip": "CPU Usage: %s%%", "class": "cpu"}\n' "$usage" "$usage"
        ;;
      1)
        read -r total available <<< "$(awk '/^MemTotal:/{t=$2} /^MemAvailable:/{a=$2} END{print t, a}' /proc/meminfo)"
        used=$(( (total - available) / 1024 ))
        total_mb=$(( total / 1024 ))
        pct=$(( (total - available) * 100 / total ))
        printf '{"text": "RAM %s%%", "tooltip": "RAM: %sMB / %sMB", "class": "ram"}\n' "$pct" "$used" "$total_mb"
        ;;
      2)
        temp="N/A"
        for hwmon in /sys/class/hwmon/hwmon*; do
          if [ -f "$hwmon/name" ] && [ "$(cat "$hwmon/name")" = "k10temp" ]; then
            if [ -f "$hwmon/temp1_input" ]; then
              raw=$(cat "$hwmon/temp1_input")
              temp=$(( raw / 1000 ))
            fi
            break
          fi
        done
        printf '{"text": "Temp %s°C", "tooltip": "CPU Temperature: %s°C", "class": "temp"}\n' "$temp" "$temp"
        ;;
    esac
  '';

  sysmonToggle = pkgs.writeShellScript "waybar-sysmon-toggle" ''
    STATE_FILE="/tmp/waybar-sysmon-state"
    [ -f "$STATE_FILE" ] || echo 0 > "$STATE_FILE"
    STATE=$(cat "$STATE_FILE")
    NEXT=$(( (STATE + 1) % 3 ))
    echo "$NEXT" > "$STATE_FILE"
  '';

  bluetoothScript = pkgs.writeShellScript "waybar-bluetooth" ''
    powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')
    if [ "$powered" != "yes" ]; then
      printf '{"text": "󰂲", "tooltip": "Bluetooth off", "class": "off"}\n'
      exit 0
    fi

    connected_device=$(bluetoothctl devices Connected 2>/dev/null | head -1 | cut -d' ' -f3-)
    if [ -n "$connected_device" ]; then
      printf '{"text": "󰂱 %s", "tooltip": "Connected: %s", "class": "connected"}\n' "$connected_device" "$connected_device"
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
        height = 34;
        spacing = 4;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/sysmon" "network" "custom/bluetooth" "pulseaudio" "battery" "tray" ];

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

        "custom/sysmon" = {
          exec = toString sysmonScript;
          return-type = "json";
          interval = 2;
          on-click = toString sysmonToggle;
        };

        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format-wifi = "{essid}\nSignal: {signalStrength}%\nIP: {ipaddr}";
          tooltip-format-ethernet = "{ifname}\nIP: {ipaddr}";
          tooltip-format-disconnected = "No connection";
          on-click = "ghostty -e nmtui";
        };

        "custom/bluetooth" = {
          exec = toString bluetoothScript;
          return-type = "json";
          interval = 5;
          on-click = "ghostty -e bluetoothctl";
        };

        battery = {
          bat = "BAT0";
          adapter = "ADP0";
          interval = 30;
          design-capacity = false;
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰚥  {capacity}%";
          format-full = "󰁹  Full";
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

        pulseaudio = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      /* Reset */
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      button {
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: #1e1e2e;
        color: #cdd6f4;
      }

      /* Pill base for all modules */
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #custom-sysmon,
      #custom-bluetooth,
      #tray {
        background-color: #313244;
        border-radius: 8px;
        padding: 0 10px;
        margin: 4px 2px;
        transition: background-color 200ms ease;
      }

      #clock:hover,
      #battery:hover,
      #pulseaudio:hover,
      #network:hover,
      #custom-sysmon:hover,
      #custom-bluetooth:hover,
      #tray:hover {
        background-color: #45475a;
      }

      /* Icon-only modules: fixed width */
      #pulseaudio,
      #network,
      #custom-bluetooth {
        padding: 0 8px;
        min-width: 20px;
      }

      /* Workspaces */
      #workspaces button {
        padding: 0 8px;
        margin: 4px 2px;
        color: #585b70;
        background: transparent;
        border-radius: 8px;
        transition: all 200ms ease;
      }

      #workspaces button:hover {
        background-color: #45475a;
        color: #cdd6f4;
      }

      /* 1-2: code/chat - blue */
      #workspaces button:nth-child(-n+2).active {
        color: #1e1e2e;
        background-color: #89b4fa;
      }

      /* 3-8: main work - mauve */
      #workspaces button:nth-child(n+3):nth-child(-n+8).active {
        color: #1e1e2e;
        background-color: #cba6f7;
      }

      /* 9-10: logs/misc - peach */
      #workspaces button:nth-child(n+9).active {
        color: #1e1e2e;
        background-color: #fab387;
      }

      /* Clock */
      #clock {
        color: #cdd6f4;
        font-weight: bold;
      }

      /* Battery */
      #battery {
        color: #a6e3a1;
      }

      #battery.good {
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

      /* Audio */
      #pulseaudio {
        color: #89b4fa;
      }

      #pulseaudio.muted {
        color: #585b70;
      }

      /* Network */
      #network {
        color: #cba6f7;
      }

      #network.disconnected {
        color: #585b70;
      }

      /* Bluetooth */
      #custom-bluetooth {
        color: #94e2d5;
      }

      #custom-bluetooth.off {
        color: #585b70;
      }

      /* System monitor */
      #custom-sysmon.cpu {
        color: #fab387;
      }

      #custom-sysmon.ram {
        color: #a6e3a1;
      }

      #custom-sysmon.temp {
        color: #f9e2af;
      }

      /* Tray */
      #tray {
        color: #cdd6f4;
      }
    '';
  };
}
