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
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator

    # Hyprland
    waybar
    hyprpaper
    grim
    slurp
    wlogout
    cliphist
    brightnessctl
    playerctl
    blueman
    pavucontrol
    networkmanagerapplet
    libnotify

    # Media
    mpv

    # Rofi
    rofi

    # Notes
    obsidian
  ] ++ [
    # External flake packages
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
}
