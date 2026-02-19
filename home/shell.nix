{ pkgs, ... }:

{
  programs = {
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

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 12;
      };
      settings = {
        scrollback_lines = 10000;
        copy_on_select = "clipboard";
        clipboard_control = "write-clipboard write-primary read-clipboard-ask read-primary-ask";
        wayland_titlebar_decorations = "client";
        enable_audio_bell = false;
      };
    };

    ghostty = {
      enable = true;
      settings = {
        clipboard-paste-bracketed-safe = true;
        clipboard-read = "allow";
      };
    };
  };
}
