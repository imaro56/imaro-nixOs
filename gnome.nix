{ lib, ... }:
{
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us,ua";
    options = lib.concatStringsSep "," [
      "grp:win_space_toggle" # Super+Space to toggle language
      "caps:swapescape" # Swap Esc and CapsLock
    ];
  };
}
