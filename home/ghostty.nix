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

      # -- Misc --
      confirm-close-surface = true;
      scrollback-limit = 10000000;
      link-url = true;
      minimum-contrast = 1.0;

      # -- Keybindings --
      keybind = [
        # Splits - create
        "ctrl+shift+enter=new_split:right"
        "ctrl+shift+d=new_split:down"

        # Splits - navigate (vim-style)
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+j=goto_split:bottom"
        "ctrl+shift+k=goto_split:top"
        "ctrl+shift+l=goto_split:right"

        # Splits - manage
        "ctrl+shift+z=toggle_split_zoom"
        "ctrl+shift+e=equalize_splits"

        # Tabs
        "ctrl+shift+t=new_tab"
        "ctrl+tab=next_tab"
        "ctrl+shift+tab=previous_tab"

        # Font size
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+0=reset_font_size"

        # Prompt navigation (shell integration)
        "ctrl+shift+up=jump_to_prompt:-1"
        "ctrl+shift+down=jump_to_prompt:1"
      ];
    };
  };
}
