{ pkgs, ... }:

{
  programs = {
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
  };
}
