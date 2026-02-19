{ inputs, ... }:

{
  imports = [
    ./shell.nix
    ./editors.nix
    ./git.nix
    ./packages.nix
    ./desktop.nix
  ];

  home.username = "imaro56";
  home.homeDirectory = "/home/imaro56";

  programs.home-manager.enable = true;

  # Don't change this
  home.stateVersion = "24.11";
}
