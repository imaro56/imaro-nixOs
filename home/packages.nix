{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Messagers
    telegram-desktop
    discord
    slack

    # Terminal tools
    tmux
    ripgrep
    btop
    unzip
    lf

    # Disk usage
    ncdu
    duf
    dust

    # Fonts
    nerd-fonts.jetbrains-mono

    # Office
    libreoffice

    # Claude Code
    claude-code
    nodejs
    uv
    playwright-mcp
  ] ++ [
    # External flake packages
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
}
