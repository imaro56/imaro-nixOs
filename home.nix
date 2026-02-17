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
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    git = {
      enable = true;
      settings.user.name = "imaro56";
      settings.user.email = "dimamarich07@gmail.com";
      includes = [{
        condition = "gitdir:~/work/";
        contents.user = {
          name = "Dima Marych";
          email = "imaro56@newtonideas.com";
        };
      }];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
    ripgrep
    btop
    unzip
    lf

    # Claude Code
    claude-code
  ] ++ [
    # External flake packages
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  # GNOME Wayland keyboard settings
  dconf.settings."org/gnome/desktop/input-sources".xkb-options = [
    "grp:win_space_toggle"
    "caps:swapescape"
  ];

  # Don't change this
  home.stateVersion = "24.11";
}
