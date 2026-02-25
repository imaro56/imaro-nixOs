{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 5;
      };

      background = [{
        color = "rgb(1e1e2e)";
      }];

      input-field = [{
        size = "300, 50";
        outline_thickness = 2;
        outer_color = "rgb(89b4fa)";
        inner_color = "rgb(313244)";
        font_color = "rgb(cdd6f4)";
        fade_on_empty = false;
        placeholder_text = "Password...";
        position = "0, -20";
        halign = "center";
        valign = "center";
      }];
    };
  };
}
