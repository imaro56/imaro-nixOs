{ ... }:

{
  services.mako = {
    enable = true;
    settings = {
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#b4befe";
      progress-color = "#89b4fa";

      width = 420;
      height = 110;
      padding = "10";
      margin = "10";
      border-size = 2;
      border-radius = 4;

      anchor = "top-right";
      layer = "overlay";

      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";

      group-by = "app-name";
      actions = true;
      markup = true;
      format = "<b>%s</b>\\n%b";
      font = "JetBrainsMono Nerd Font 12";
    };
  };
}
