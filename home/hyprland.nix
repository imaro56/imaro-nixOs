{ pkgs, ... }:
let
  workspaces = builtins.concatLists (builtins.genList
    (i:
      let ws = i + 1;
      in [
        "$mod, ${toString (if ws == 10 then 0 else ws)}, workspace, ${toString ws}"
        "$mod SHIFT, ${toString (if ws == 10 then 0 else ws)}, movetoworkspace, ${toString ws}"
      ])
    10);
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;

    settings = {
      "$mod" = "SUPER";

      monitor = [
        "eDP-1, 1920x1080@165, 0x0, 1"
        "DP-3, 1920x1080@60, 1920x0, 1"
        "DP-4, 1920x1080@60, 3840x0, 1, transform, 1"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        border_size = 2;
        gaps_in = 4;
        gaps_out = 8;
        "col.active_border" = "rgb(b4befe)"; # Catppuccin Mocha lavender
        "col.inactive_border" = "rgb(313244)"; # Catppuccin Mocha surface0
        layout = "dwindle";
        resize_on_border = true;
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        blur = {
          enabled = true;
          size = 6;
          passes = 2;
        };
        shadow = {
          enabled = true;
          range = 8;
          color = "rgb(1e1e2e)"; # Catppuccin Mocha base
        };
      };

      animations = {
        enabled = true;
        bezier = "snappy, 0.05, 0.9, 0.1, 1.0";
        animation = [
          "windows, 1, 4, snappy, slide"
          "windowsOut, 1, 4, snappy, slide"
          "fade, 1, 4, snappy"
          "workspaces, 1, 4, snappy, slide"
        ];
      };

      input = {
        kb_layout = "us,ua";
        kb_options = "grp:win_space_toggle,caps:swapescape";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          disable_while_typing = true;
        };
      };

      gesture = "3, horizontal, workspace";

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };

      workspace = [
        "1, monitor:eDP-1, default:true"
        "2, monitor:DP-3, default:true"
        "3, monitor:DP-3"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        "6, monitor:DP-3"
        "7, monitor:DP-3"
        "8, monitor:DP-3"
        "9, monitor:DP-3"
        "10, monitor:DP-4, default:true"
      ];

      bind = [
        # Apps
        "$mod, Return, exec, ghostty"
        "$mod, Q, killactive,"
        "$mod, D, exec, rofi -show drun"
        "$mod, E, exec, nautilus"
        "$mod, B, exec, zen-beta"

        # Window management
        "$mod, M, fullscreen, 1"
        "$mod, F, fullscreen, 0"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, T, togglesplit,"

        # Focus movement (vim-style)
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Move windows
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Resize
        "$mod CTRL, h, resizeactive, -40 0"
        "$mod CTRL, l, resizeactive, 40 0"
        "$mod CTRL, k, resizeactive, 0 -40"
        "$mod CTRL, j, resizeactive, 0 40"

        # Screenshot
        ''$mod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''
      ] ++ workspaces;

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "waybar"
        "mako"
        "hyprpaper"
      ];
    };
  };
}
