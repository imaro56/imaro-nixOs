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

    ghostty = {
      enable = true;
      settings = {
        clipboard-paste-bracketed-safe = true;
        clipboard-read = "allow";
      };
    };
  };
}
