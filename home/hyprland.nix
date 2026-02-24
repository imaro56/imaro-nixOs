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
        "DP-4, 1920x1080@60, 3840x-420, 1, transform, 1"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,Adwaita"
        "HYPRCURSOR_THEME,Adwaita"

        # Force Wayland
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "OZONE_PLATFORM,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"

        # NVIDIA
        "NVD_BACKEND,direct"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      general = {
        border_size = 2;
        gaps_in = 5;
        gaps_out = 10;
        "col.active_border" = "rgb(b4befe)"; # Catppuccin Mocha lavender
        "col.inactive_border" = "rgb(313244)"; # Catppuccin Mocha surface0
        layout = "dwindle";
        resize_on_border = true;
        allow_tearing = false;
      };

      decoration = {
        rounding = 4;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
        shadow = {
          enabled = true;
          range = 2;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 0, 0, ease"
        ];
      };

      input = {
        kb_layout = "us,ua";
        kb_options = "grp:win_space_toggle,caps:swapescape";
        follow_mouse = 1;
        sensitivity = 0;
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
        force_split = 2;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        focus_on_activate = true;
      };

      cursor = {
        hide_on_key_press = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      ecosystem = {
        no_update_news = true;
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

      windowrule = [
        # Window opacity
        "opacity 0.97 0.9, match:class .*"
        "opacity 1 1, match:class ^(vlc|mpv|com.obsproject.Studio)$"
        "opacity 1 1, match:class ^(steam)$"

        # Float specific apps
        "float on, match:class ^(org.pulseaudio.pavucontrol|blueberry.py)$"
        "float on, match:class ^(steam)$"
      ];

      layerrule = [
        "blur on, match:namespace waybar"
      ];

      bind = [
        # Apps
        "$mod, Return, exec, ghostty"
        "$mod, W, killactive,"
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

        # Move windows (vim-style)
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Also support arrow keys for focus/move
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, left, swapwindow, l"
        "$mod SHIFT, right, swapwindow, r"
        "$mod SHIFT, up, swapwindow, u"
        "$mod SHIFT, down, swapwindow, d"

        # Resize (vim-style)
        "$mod CTRL, h, resizeactive, -100 0"
        "$mod CTRL, l, resizeactive, 100 0"
        "$mod CTRL, k, resizeactive, 0 -100"
        "$mod CTRL, j, resizeactive, 0 100"

        # Resize (omarchy-style)
        "$mod, minus, resizeactive, -100 0"
        "$mod, equal, resizeactive, 100 0"
        "$mod SHIFT, minus, resizeactive, 0 -100"
        "$mod SHIFT, equal, resizeactive, 0 100"

        # Workspace cycling
        "$mod, TAB, workspace, e+1"
        "$mod SHIFT, TAB, workspace, e-1"
        "$mod, comma, workspace, -1"
        "$mod, period, workspace, +1"

        # Move workspace to monitor
        "$mod SHIFT ALT, left, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, right, movecurrentworkspacetomonitor, r"
        "$mod SHIFT ALT, up, movecurrentworkspacetomonitor, u"
        "$mod SHIFT ALT, down, movecurrentworkspacetomonitor, d"
        "$mod SHIFT ALT, h, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, l, movecurrentworkspacetomonitor, r"
        "$mod SHIFT ALT, k, movecurrentworkspacetomonitor, u"
        "$mod SHIFT ALT, j, movecurrentworkspacetomonitor, d"

        # Alt-tab window cycling
        "ALT, TAB, cyclenext"
        "ALT SHIFT, TAB, cyclenext, prev"
        "ALT, TAB, bringactivetotop"

        # Scratchpad
        "$mod, S, togglespecialworkspace, scratchpad"
        "$mod ALT, S, movetoworkspacesilent, special:scratchpad"

        # Screenshots
        ''$mod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''
        ''$mod SHIFT, F, exec, grim -o $(hyprctl activeworkspace -j | jq -r '.monitor') - | wl-copy''

        # Session
        "$mod, ESCAPE, exec, hyprlock"
        "$mod SHIFT, ESCAPE, exit,"

        # Scroll through workspaces with mouse
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Toggle waybar
        "$mod SHIFT, SPACE, exec, pkill -SIGUSR1 waybar"
      ] ++ workspaces;

      # Media keys (repeat on hold)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Media keys (trigger once)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "waybar"
        "mako"
        "hyprpaper"
        "hypridle"
      ];
    };
  };
}
