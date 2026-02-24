{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        no_fade_in = false;
      };
      background = {
        monitor = "";
        color = "rgb(1e1e2e)";
        blur_passes = 3;
        brightness = 0.5;
      };
      input-field = {
        monitor = "";
        size = "600, 100";
        position = "0, 0";
        halign = "center";
        valign = "center";

        inner_color = "rgb(313244)";
        outer_color = "rgb(b4befe)";
        outline_thickness = 4;

        font_family = "JetBrainsMono Nerd Font";
        font_size = 32;
        font_color = "rgb(cdd6f4)";

        placeholder_color = "rgb(6c7086)";
        placeholder_text = "  Enter Password";
        check_color = "rgb(a6e3a1)";
        fail_text = "Wrong";

        rounding = 4;
        shadow_passes = 0;
        fade_on_empty = false;
      };
    };
  };
}
