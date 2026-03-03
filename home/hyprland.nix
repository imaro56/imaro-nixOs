{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "eDP-2, 1920x1080@165, 0x0, 1"
        "DP-3, 1920x1080, 1920x0, 1"
        "DP-4, 1920x1080, 3840x-420, 1, transform, 1"
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
        force_split = 2;
      };

      cursor = {
        warp_on_change_workspace = true;
      };

      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      workspace = [
        # Left monitor (eDP-2) — comms & reference
        "1, monitor:eDP-2, default:true"
        "2, monitor:eDP-2"
        # Center monitor (DP-3) — main work
        "3, monitor:DP-3, default:true"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        "6, monitor:DP-3"
        "7, monitor:DP-3"
        "8, monitor:DP-3"
        # Right monitor (DP-4) — logs & docs (portrait)
        "9, monitor:DP-4, default:true"
        "10, monitor:DP-4"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      bind = [
        # Apps
        "$mod, Return, exec, ghostty"
        "$mod, D, exec, rofi -show drun -show-icons"
        "$mod, E, exec, thunar"
        "$mod, B, exec, zen-beta"

        # Window management
        "$mod, W, killactive"
        "$mod, M, fullscreen"
        "$mod, F, togglefloating"

        # Focus (vim + arrows)
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, left, movefocus, l"
        "$mod, down, movefocus, d"
        "$mod, up, movefocus, u"
        "$mod, right, movefocus, r"

        # Move window (vim + arrows)
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, right, movewindow, r"

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

        # Scroll workspaces
        "$mod, bracketleft, workspace, r-1"
        "$mod, bracketright, workspace, r+1"

        # Move to adjacent workspace + follow
        "$mod SHIFT, bracketleft, movetoworkspace, r-1"
        "$mod SHIFT, bracketright, movetoworkspace, r+1"

        # Move to adjacent workspace silently
        "$mod CTRL, bracketleft, movetoworkspacesilent, r-1"
        "$mod CTRL, bracketright, movetoworkspacesilent, r+1"

        # Move to workspace silently (stay on current)
        "$mod CTRL, 1, movetoworkspacesilent, 1"
        "$mod CTRL, 2, movetoworkspacesilent, 2"
        "$mod CTRL, 3, movetoworkspacesilent, 3"
        "$mod CTRL, 4, movetoworkspacesilent, 4"
        "$mod CTRL, 5, movetoworkspacesilent, 5"
        "$mod CTRL, 6, movetoworkspacesilent, 6"
        "$mod CTRL, 7, movetoworkspacesilent, 7"
        "$mod CTRL, 8, movetoworkspacesilent, 8"
        "$mod CTRL, 9, movetoworkspacesilent, 9"
        "$mod CTRL, 0, movetoworkspacesilent, 10"

        # Scratchpad (special workspace)
        "$mod, S, togglespecialworkspace, scratchpad"
        "$mod SHIFT, S, movetoworkspacesilent, special:scratchpad"

        # Monitor focus (left / center / right)
        "$mod, comma, focusmonitor, eDP-2"
        "$mod, period, focusmonitor, DP-3"
        "$mod, slash, focusmonitor, DP-4"

        # Screenshot
        ", Print, exec, grimblast --freeze copysave area ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"
        "$mod, Print, exec, grimblast --freeze copysave screen ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"
        "$mod, P, exec, grimblast --freeze copysave area ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"
        "$mod SHIFT, P, exec, grimblast --freeze copysave screen ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"
        "$mod ALT, P, exec, grimblast --freeze copysave output ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"

        # Lock
        "$mod, Escape, exec, hyprlock"

        # Resize mode
        "$mod, R, submap, resize"

        # Reload config
        "$mod SHIFT, R, exec, hyprctl reload"

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
        "lxqt-policykit-agent"
        "waybar"
        "mako"
        "hypridle"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "swww-daemon"
        "swww img /home/imaro56/wallpaper.png"
      ];
    };

    extraConfig = ''
      submap = resize
      binde = , H, resizeactive, -20 0
      binde = , L, resizeactive, 20 0
      binde = , K, resizeactive, 0 -20
      binde = , J, resizeactive, 0 20
      binde = , left, resizeactive, -20 0
      binde = , right, resizeactive, 20 0
      binde = , up, resizeactive, 0 -20
      binde = , down, resizeactive, 0 20
      bind = , escape, submap, reset
      bind = , return, submap, reset
      submap = reset
    '';
  };

}
