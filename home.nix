{ config, pkgs, inputs, ... }:

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
    
  ] ++ [
    # for external flake packages
    inputs.zen-browser.packages."${pkgs.system}".default
  ];

  # Don't change this
  home.stateVersion = "24.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
