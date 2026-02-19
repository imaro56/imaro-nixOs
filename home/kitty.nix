{ ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      # Scrollback
      scrollback_lines = 10000;

      # Clipboard
      copy_on_select = "clipboard";
      clipboard_control = "write-clipboard write-primary read-clipboard-ask read-primary-ask";

      # Window
      hide_window_decorations = true;
      window_padding_width = 10;
      confirm_os_window_close = 0;

      # Cursor
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";

      # Tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 1;
      active_tab_font_style = "bold";

      # Mouse
      mouse_hide_wait = "-1.0";

      # Bell
      enable_audio_bell = false;
    };
  };
}
