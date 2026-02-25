{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      # No extraConfig - LazyVim manages everything via ~/.config/nvim
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

  # LazyVim runtime dependencies
  home.packages = with pkgs; [
    gcc # treesitter compilation
    gnumake
    fd # file finder (used by telescope)
    lazygit # git TUI (LazyVim integrates with it)
  ];
}
