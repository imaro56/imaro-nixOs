{ pkgs, inputs, ... }:

{
  home.packages =
    with pkgs;
    [
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
      psmisc
      lsof

      # Disk usage
      ncdu
      duf
      dust

      # Fonts
      nerd-fonts.jetbrains-mono

      # Browsers
      brave
      librewolf
      firefox-devedition
      tor-browser

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

      # Media
      mpv

      # Notes
      obsidian

      # Time tracking
      python313Packages.toggl-cli
      uair

      # Proton
      proton-pass
      proton-pass-cli
      
      # Google alternatives
      freetube
      spotube
    ]
    ++ [
      # External flake packages
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
}
