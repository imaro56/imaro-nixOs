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

    # Office
    onlyoffice-desktopeditors

    # Claude Code
    claude-code
    nodejs
    uv
    playwright-mcp

    # GNOME extensions
    gnomeExtensions.appindicator
    gnomeExtensions.notification-timeout
    gnomeExtensions.tiling-shell
    gnomeExtensions.clipboard-history

    # Hyprland tools
    rofi
    grimblast
    cliphist
    brightnessctl
    playerctl
    swww
    nautilus

    # Utilities
    pavucontrol
    libnotify
    overskride

    # Media
    mpv

    # Notes
    obsidian
  ] ++ [
    # External flake packages
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
}
