{ ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };


    settings = {
      # Scrollback
      scrollback_lines = 10000;

      # Clipboard
      copy_on_select = "clipboard";
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary-ask";

      # Window
      hide_window_decorations = true;
      window_padding_width = "2 10 5";
      confirm_os_window_close = 0;

      # Cursor
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_trail = 20;
      cursor_trail_decay = "0.1 0.4";

      # Tab bar
      tab_bar_edge = "top";
      tab_bar_align = "center";
      tab_bar_style = "separator";
      tab_separator = "\" | \"";
      tab_bar_min_tabs = 1;
      tab_title_max_length = 30;
      active_tab_foreground = "#CBA6F7";
      active_tab_background = "#1E1E2E";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#1E1E2E";
      tab_bar_background = "none";

      # Mouse
      mouse_hide_wait = "-1.0";

      # Bell
      enable_audio_bell = false;

      # Shell integration
      shell_integration = "enabled";

      # Layouts
      enabled_layouts = "splits,stack";

      # Tabs
      tab_spawn_location = "neighbor";
    };

    keybindings = {
      # Focus neighboring window
      "kitty_mod+h" = "neighboring_window left";
      "kitty_mod+j" = "neighboring_window down";
      "kitty_mod+k" = "neighboring_window up";
      "kitty_mod+l" = "neighboring_window right";
      "ctrl+shift+left" = "neighboring_window left";
      "ctrl+shift+down" = "neighboring_window down";
      "ctrl+shift+up" = "neighboring_window up";
      "ctrl+shift+right" = "neighboring_window right";

      # Move window
      "ctrl+shift+alt+h" = "move_window left";
      "ctrl+shift+alt+j" = "move_window down";
      "ctrl+shift+alt+k" = "move_window up";
      "ctrl+shift+alt+l" = "move_window right";
      "ctrl+shift+alt+left" = "move_window left";
      "ctrl+shift+alt+down" = "move_window down";
      "ctrl+shift+alt+up" = "move_window up";
      "ctrl+shift+alt+right" = "move_window right";

      # Splits
      "kitty_mod+\\" = "launch --cwd=current --location=vsplit";

      # New tab with current directory
      "kitty_mod+t" = "new_tab_with_cwd";

      # Tab switching
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";

      # Open line in nvim
      "ctrl+g" = "kitten hints --type=linenum --linenum-action=tab nvim +{line} {path}";
    };
  };
}
