{ ... }:

{
  dconf.settings = {
    # Keyboard layout
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "grp:win_space_toggle"
        "caps:swapescape"
      ];
    };

    # Disable Super+N app switching (frees Super+N for workspaces)
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };

    # Window management and workspace keybindings
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-maximized = [ "<Super>m" ];
      minimize = [ "<Super>comma" ];

      # Switch to workspace by number
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];

      # Move window to workspace
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];

      # Window switching
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    # Register custom keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
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
  };
}
