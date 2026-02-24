{ pkgs, ... }:
  {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;           
      systemd.enable = false;
      settings = {
        "$mod" = "SUPER";

	bind = [
          "$mod, Return, exec, ghostty"
	  "$mod, Q, killactive,"
	  "$mod, D, exec, rofi -show drun"
	];
      };
    };
  }
