{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # -- Theme --
      theme = "Catppuccin Mocha";

      # -- Font --
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
      font-feature = [ "+liga" "+calt" ];
      font-synthetic-style = false;

      # -- Window --
      window-padding-x = 16;
      window-padding-y = 14;
      window-padding-balance = true;
      window-padding-color = "background";
      window-decoration = "auto";
      gtk-titlebar-style = "tabs";
      gtk-single-instance = "desktop";

      # -- Transparency --
      background-opacity = 0.88;
      background-blur = 20;
      unfocused-split-opacity = 0.85;

      # -- Cursor --
      cursor-style = "block";
      cursor-style-blink = false;

      # -- Clipboard --
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-paste-bracketed-safe = true;
      clipboard-paste-protection = true;
      clipboard-trim-trailing-spaces = true;
      copy-on-select = true;

      # -- Shell --
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title";

      # -- Mouse --
      mouse-hide-while-typing = true;

      # -- Window behavior --
      window-inherit-working-directory = true;
      window-inherit-font-size = true;

      # -- Security --
      title-report = false;

      # -- Misc --
      confirm-close-surface = true;
      scrollback-limit = 10000000;
      link-url = true;
      minimum-contrast = 1.0;

      # -- Keybindings --
      keybind = [
        "clear"

        # Clipboard
        "performable:ctrl+c=copy:clipboard"
        "ctrl+shift+c=copy:clipboard"
        "ctrl+shift+v=paste:clipboard"

        # Splits - create
        "ctrl+shift+enter=new_split:right"
        "ctrl+shift+d=new_split:down"

        # Splits - navigate
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+j=goto_split:bottom"
        "ctrl+shift+k=goto_split:top"
        "ctrl+shift+l=goto_split:right"

        # Splits - resize
        "ctrl+alt+h=resize_split:left,40"
        "ctrl+alt+j=resize_split:down,40"
        "ctrl+alt+k=resize_split:up,40"
        "ctrl+alt+l=resize_split:right,40"

        # Splits - manage
        "ctrl+shift+z=toggle_split_zoom"
        "ctrl+shift+e=equalize_splits"

        # Tabs - navigate
        "ctrl+shift+t=new_tab"
        "ctrl+tab=next_tab"
        "ctrl+shift+tab=previous_tab"
        "alt+1=goto_tab:1"
        "alt+2=goto_tab:2"
        "alt+3=goto_tab:3"
        "alt+4=goto_tab:4"
        "alt+5=goto_tab:5"
        "alt+6=goto_tab:6"
        "alt+7=goto_tab:7"
        "alt+8=goto_tab:8"
        "alt+9=last_tab"

        # Close
        "ctrl+shift+w=close_surface"

        # Font size
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+0=reset_font_size"

        # Scroll
        "shift+page_up=scroll_page_up"
        "shift+page_down=scroll_page_down"
        "shift+home=scroll_to_top"
        "shift+end=scroll_to_bottom"

        # Prompt navigation
        "ctrl+shift+up=jump_to_prompt:-1"
        "ctrl+shift+down=jump_to_prompt:1"

        # Tools
        "ctrl+shift+p=toggle_command_palette"
        "ctrl+shift+i=inspector:toggle"
        "ctrl+shift+comma=reload_config"
        "ctrl+shift+backspace=reset"
      ];
    };
  };
}
