{ pkgs, lib, ... }:

{
  imports = [
    ./shell.nix
    ./ghostty.nix
    ./editors.nix
    ./git.nix
    ./packages.nix
    ./gtk.nix
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./rofi-projects.nix
    ./mako.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./uair.nix
  ];

  home.username = "imaro56";
  home.homeDirectory = "/home/imaro56";

  xdg.portal = {
    enable = lib.mkForce true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
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
