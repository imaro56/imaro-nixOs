{ pkgs, config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;

  powerMenu = pkgs.writeShellScript "rofi-power-menu" ''
    choice=$(printf "󰌾 Lock\n󰤄 Suspend\n󰍃 Logout\n󰜉 Reboot\n󰐥 Shutdown" | \
      rofi -dmenu -p "Power" -theme-str 'window {width: 300px;} listview {lines: 5;}')

    case "$choice" in
      "󰌾 Lock")     hyprlock ;;
      "󰤄 Suspend")  systemctl suspend ;;
      "󰍃 Logout")   hyprctl dispatch exit ;;
      "󰜉 Reboot")   systemctl reboot ;;
      "󰐥 Shutdown") systemctl poweroff ;;
    esac
  '';
in
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER SHIFT, Escape, exec, ${powerMenu}"
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = [ pkgs.rofi-calc pkgs.rofi-emoji ];
    terminal = "ghostty";
    font = "JetBrainsMono Nerd Font 13";

    extraConfig = {
      modi = "drun,run,calc,emoji";
      show-icons = true;
      display-drun = "Apps";
      display-run = "Run";
      display-calc = "Calc";
      display-emoji = "Emoji";
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = true;
      scroll-method = 0;
      hide-scrollbar = true;
    };

    theme = let
      # Catppuccin Mocha palette
      bg = "#1e1e2e";
      bg-alt = "#181825";
      surface0 = "#313244";
      text = "#cdd6f4";
      subtext0 = "#a6adc8";
      blue = "#89b4fa";
      transparent = "transparent";
    in {
      "*" = {
        background-color = mkLiteral transparent;
        text-color = mkLiteral text;
      };

      window = {
        width = mkLiteral "600px";
        background-color = mkLiteral bg;
        border = mkLiteral "2px solid";
        border-color = mkLiteral surface0;
        border-radius = mkLiteral "8px";
        padding = mkLiteral "0";
      };

      mainbox = {
        children = map mkLiteral [ "inputbar" "listview" "mode-switcher" ];
        spacing = mkLiteral "0";
        padding = mkLiteral "0";
      };

      inputbar = {
        children = map mkLiteral [ "prompt" "entry" ];
        padding = mkLiteral "12px";
        background-color = mkLiteral bg;
        spacing = mkLiteral "8px";
      };

      prompt = {
        background-color = mkLiteral blue;
        text-color = mkLiteral bg;
        padding = mkLiteral "6px 12px";
        border-radius = mkLiteral "6px";
        font = "JetBrainsMono Nerd Font Bold 13";
      };

      entry = {
        padding = mkLiteral "6px 0";
        text-color = mkLiteral text;
        placeholder = "Search...";
        placeholder-color = mkLiteral subtext0;
      };

      listview = {
        lines = 8;
        columns = 1;
        fixed-height = true;
        padding = mkLiteral "4px 8px";
        background-color = mkLiteral bg;
        spacing = mkLiteral "4px";
      };

      element = {
        padding = mkLiteral "8px 12px";
        border-radius = mkLiteral "6px";
        spacing = mkLiteral "8px";
      };

      "element selected" = {
        background-color = mkLiteral surface0;
        text-color = mkLiteral blue;
      };

      element-icon = {
        size = mkLiteral "24px";
      };

      element-text = {
        highlight = mkLiteral "bold ${blue}";
      };

      "mode-switcher" = {
        background-color = mkLiteral bg-alt;
        padding = mkLiteral "8px";
        spacing = mkLiteral "8px";
      };

      button = {
        padding = mkLiteral "6px 16px";
        border-radius = mkLiteral "6px";
        text-color = mkLiteral subtext0;
        background-color = mkLiteral transparent;
      };

      "button selected" = {
        background-color = mkLiteral surface0;
        text-color = mkLiteral blue;
      };
    };
  };
}
