{ inputs, pkgs, lib, ... }:

{
  imports = [
    ./shell.nix
    ./kitty.nix
    ./ghostty.nix
    ./editors.nix
    ./git.nix
    ./packages.nix
    ./gnome.nix
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./mako.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.username = "imaro56";
  home.homeDirectory = "/home/imaro56";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.portal = {
    enable = lib.mkForce true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
      gnome.default = [ "gnome" "gtk" ];
    };
  };

  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu -i
    [editor]
    terminal = ghostty
  '';

  programs.home-manager.enable = true;

  # Don't change this
  home.stateVersion = "24.11";
}
