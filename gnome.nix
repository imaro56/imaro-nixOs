{ lib, ... }:
{
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us,ua";
    options = lib.concatStringsSep "," [
      "grp:caps_toggle" # CapsLock toggles language (keyd swaps physical keys before XKB)
    ];
  };

  # Swap Escape and CapsLock at input level (before XKB)
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "escape";
        escape = "capslock";
      };
    };
  };
}
