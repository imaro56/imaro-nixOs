{ ... }:

{
  dconf.settings = {
    # Enable GNOME extensions
    "org/gnome/shell" = {
      enabled-extensions = [
        "notification-timeout@chlumsern.gmail.com"
        "tilingshell@ferrarodomenico.com"
        "appindicatorsupport@rgcjonas.gmail.com"
      ];
    };
    # Keyboard layout
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "grp:caps_toggle"
      ];
    };

    # Notification timeout (5 seconds)
    "org/gnome/shell/extensions/notification-timeout" = {
      timeout = 5000;
      ignore-idle = true;
      always-normal = true;
    };

    # Touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      click-method = "fingers";
    };

    # Disable Super+N app switching (frees Super+N for workspaces)
    # Disable Super+M message tray (frees Super+M for toggle-maximized)
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      toggle-message-tray = [];
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };

    # Workspaces & compositing
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      num-workspaces = 6;
      experimental-features = [ "variable-refresh-rate" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 6;
      focus-mode = "sloppy"; # focus window under mouse without clicking
    };

    # Window management and workspace keybindings
    "org/gnome/desktop/wm/keybindings" = {
      # Disable Super+Space language toggle (only CapsLock toggles)
      switch-input-source = [];
      switch-input-source-backward = [];

      close = [ "<Super>w" ];
      toggle-maximized = [ "<Super>m" ];
      minimize = [ "<Super>comma" ];

      # Switch to workspace by number
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];

      # Move window to workspace
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      move-to-workspace-6 = [ "<Shift><Super>6" ];

      # Window switching
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    # Register custom keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };

    # Custom: launch terminal
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "ghostty";
      binding = "<Super>Return";
    };

    # Custom: file manager
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "File Manager";
      command = "nautilus";
      binding = "<Super>e";
    };

    # Custom: browser
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Zen Browser";
      command = "zen-beta";
      binding = "<Super>b";
    };
  };
}
