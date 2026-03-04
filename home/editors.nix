{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      # LazyVim config is symlinked from ./dotfiles/nvim
    };

    # Zed - fast GPU-accelerated editor
    zed-editor = {
      enable = true;
      extraPackages = with pkgs; [
        nixd
        nil
      ];
    };
  };

  xdg.configFile."nvim".source = ./dotfiles/nvim;

  # LazyVim runtime dependencies
  home.packages = with pkgs; [
    gcc # treesitter compilation
    gnumake
    fd # file finder (used by telescope)
    lazygit # git TUI (LazyVim integrates with it)
  ];
}
