{ config, pkgs, ... }:

{
  home.username = "imaro56";
  home.homeDirectory = "/home/imaro56";

  # Git configuration
  programs.git = {
    enable = true;
    userName = "imaro56";
    userEmail = "dimamarich07@gmail.com";
  };

  # Packages managed by Home Manager
  home.packages = with pkgs; [
    # Add user apps here later, e.g.:
    # firefox
    # discord
  ];

  # Don't change this
  home.stateVersion = "24.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
