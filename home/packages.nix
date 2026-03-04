{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Messagers
    telegram-desktop
    discord
    slack

    # Terminal tools
    ripgrep
    btop
    unzip
    yazi
    fastfetch

    # Disk usage
    ncdu
    duf
    dust

    # Fonts
    nerd-fonts.jetbrains-mono

    # Browsers
    google-chrome

    # Office
    onlyoffice-desktopeditors

    # Claude Code
    inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    nodejs
    uv
    playwright-mcp

    # Hyprland tools
    grimblast
    cliphist
    brightnessctl
    playerctl
    swww
    thunar
    thunar-volman
    thunar-archive-plugin
    networkmanager_dmenu

    # Utilities
    lxqt.lxqt-policykit
    pavucontrol
    libnotify
    overskride
    keepassxc

    # Media
    mpv

    # Notes
    obsidian
  ] ++ [
    # External flake packages
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
}
