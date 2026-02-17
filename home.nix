{ config, pkgs, inputs, ... }:

{
  home.username = "imaro56";
  home.homeDirectory = "/home/imaro56";

  programs = {
    # Shell
    fish = {
      enable = true;
      shellAliases = {
        rebuild = "cd ~/nixos-config && git add . && sudo nixos-rebuild switch --flake .";
        conf = "cd ~/nixos-config && vim .";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    # Editors
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      extraConfig = ''
        set clipboard=unnamedplus
        set number
        set relativenumber
      '';
    };

    # Tools
    # Tools
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    git = {
      enable = true;
      userName = "imaro56";
      userEmail = "dimamarich07@gmail.com";
    };

    home-manager.enable = true;
  };
  

  # Packages managed by Home Manager
  home.packages = with pkgs; [
    # Messagers
    telegram-desktop
    discord
    slack
    
    # Terminal tools
    tmux # terminal manager
    fzf
    ripgrep
    btop
    unzip
    lf

    # Claude code
    claude-code
  ] ++ [
    # for external flake packages
    inputs.zen-browser.packages."${pkgs.system}".default
  ];

  # Don't change this
  home.stateVersion = "24.11";
}
