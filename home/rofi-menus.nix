{ pkgs, ... }:

let
  menuTheme = title: lines: ''-theme-str '
    window {width: 300px; border-radius: 8px;}
    mainbox {children: [inputbar, listview]; spacing: 0;}
    inputbar {enabled: true; children: [entry]; padding: 12px 16px; background-color: #181825; border: 0 0 2px 0; border-color: #313244;}
    entry {enabled: true; text-color: transparent; cursor-width: 0px; placeholder: "${title}"; placeholder-color: #89b4fa; placeholder-markup: true;}
    listview {lines: ${toString lines}; padding: 8px; spacing: 4px;}
    element {padding: 8px 12px; border-radius: 6px; spacing: 8px;}
    element selected {background-color: #313244;}
    element-icon {size: 24px;}
    element-text {highlight: bold #89b4fa;}
  ' '';

  browserMenu = pkgs.writeShellScript "rofi-browsers" ''
    chosen=$(echo -en "b  Brave\0icon\x1fbrave-browser\nf  Firefox\0icon\x1ffirefox-developer-edition\nl  Librewolf\0icon\x1flibrewolf\nt  Tor\0icon\x1ftor-browser" | \
      rofi -dmenu -auto-select -i -matching prefix -show-icons \
        ${menuTheme "Select Browser" 4})
    case "$chosen" in
      b*) brave ;;
      f*) firefox-devedition ;;
      l*) librewolf ;;
      t*) tor-browser ;;
    esac
  '';

  commsMenu = pkgs.writeShellScript "rofi-comms" ''
    chosen=$(echo -en "s  Slack\0icon\x1fslack\nd  Discord\0icon\x1fdiscord\nt  Telegram\0icon\x1ftelegram" | \
      rofi -dmenu -auto-select -i -matching prefix -show-icons \
        ${menuTheme "Select Comms" 3})
    case "$chosen" in
      s*) slack ;;
      d*) discord ;;
      t*) telegram-desktop ;;
    esac
  '';

  appsMenu = pkgs.writeShellScript "rofi-apps" ''
    chosen=$(echo -en "z  Zed\0icon\x1fzed\no  Obsidian\0icon\x1fobsidian\nf  OnlyOffice\0icon\x1fonlyoffice-desktopeditors\nt  Thunar\0icon\x1fthunar\np  Pavucontrol\0icon\x1favailable-audio\nb  Bluetooth\0icon\x1fbluetooth" | \
      rofi -dmenu -auto-select -i -matching prefix -show-icons \
        ${menuTheme "Select App" 6})
    case "$chosen" in
      z*) zeditor ;;
      o*) obsidian ;;
      f*) onlyoffice-desktopeditors ;;
      t*) thunar ;;
      p*) pavucontrol ;;
      b*) overskride ;;
    esac
  '';

  powerMenu = pkgs.writeShellScript "rofi-power" ''
    chosen=$(printf 'l  󰌾 Lock\ns  󰤄 Suspend\no  󰍃 Logout\nr  󰜉 Reboot\nq  󰐥 Shutdown' | \
      rofi -dmenu -auto-select -i -matching prefix \
        ${menuTheme "Power" 5})
    case "$chosen" in
      l*) hyprlock ;;
      s*) systemctl suspend ;;
      o*) hyprctl dispatch exit ;;
      r*) systemctl reboot ;;
      q*) systemctl poweroff ;;
    esac
  '';

  mediaMenu = pkgs.writeShellScript "rofi-media" ''
    chosen=$(echo -en "m  MPV\0icon\x1fmpv\ny  FreeTube\0icon\x1ffreetube\ns  Spotube\0icon\x1fspotube" | \
      rofi -dmenu -auto-select -i -matching prefix -show-icons \
        ${menuTheme "Select Media" 3})
    case "$chosen" in
      m*) mpv ;;
      y*) freetube ;;
      s*) spotube ;;
    esac
  '';
in
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, B, exec, ${browserMenu}"
    "SUPER, C, exec, ${commsMenu}"
    "SUPER, A, exec, ${appsMenu}"
    "SUPER, X, exec, ${mediaMenu}"
    "SUPER, Escape, exec, ${powerMenu}"
  ];
}