{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "eDP-2, 1920x1080@165, 0x0, 1"
        "DP-3, 1920x1080, 1920x0, 1"
        "DP-4, 1920x1080, 3840x420, 1, transform, 1"
        ", preferred, auto, 1"
      ];

      "$mod" = "SUPER";

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgb(89b4fa)";
        "col.inactive_border" = "rgb(313244)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        blur.enabled = false;
        shadow.enabled = false;
      };

      animations = {
        enabled = true;
        bezier = "snappy, 0.05, 0.9, 0.1, 1.0";
        animation = [
          "windows, 1, 2, snappy, slide"
          "fade, 1, 2, snappy"
          "workspaces, 1, 2, snappy, slide"
        ];
      };

      input = {
        kb_layout = "us,ua";
        kb_options = "grp:caps_toggle";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          "tap-to-click" = true;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      cursor = {
        warp_on_change_workspace = true;
      };

      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      render = {
        explicit_sync = 1;
      };

      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      bind = [
        # Apps
        "$mod, Return, exec, ghostty"
        "$mod, D, exec, rofi -show drun -show-icons"
        "$mod, E, exec, nautilus"
        "$mod, B, exec, zen-beta"

        # Window management
        "$mod, W, killactive"
        "$mod, M, fullscreen"
        "$mod, F, togglefloating"

        # Focus (vim)
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        # Move window (vim)
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Screenshot
        "$mod, S, exec, grimblast --freeze copy area"
        "$mod SHIFT, S, exec, grimblast --freeze copy screen"

        # Lock
        "$mod, Escape, exec, hyprlock"

        # Clipboard history
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      exec-once = [
        "waybar"
        "mako"
        "hypridle"
        "wl-paste --watch cliphist store"
        "hyprpaper"
      ];
    };
  };

  # Hyprpaper wallpaper config
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/wallpaper.png
    wallpaper = , ~/wallpaper.png
    splash = false
  '';
}
