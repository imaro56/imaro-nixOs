{ pkgs, inputs, ... }:

{
  home.packages =
    with pkgs;
    [
      # Messagers
      telegram-desktop
      discord
      slack

      # University
      teams-for-linux # Microsoft Teams client

      # Terminal tools
      ripgrep # fast grep replacement (rg)
      btop # system monitor
      unzip # extract zip archives
      yazi # terminal file manager
      fastfetch # system info display
      psmisc # process utilities (killall, pstree)
      lsof # list open files and ports
      bat # cat with syntax highlighting
      eza # modern ls replacement
      fzf # fuzzy finder
      zoxide # smarter cd that learns your directories
      lazygit # git TUI
      fd # fast find replacement
      tldr # simplified man pages with examples

      # Build tools (needed for neovim treesitter)
      gcc # C compiler
      gnumake # make build tool

      # Disk usage
      ncdu # interactive disk usage explorer
      duf # disk free space viewer
      dust # intuitive du replacement

      # Fonts
      nerd-fonts.jetbrains-mono

      # Browsers
      brave
      librewolf # privacy-focused Firefox fork
      firefox-devedition
      tor-browser

      # Office
      onlyoffice-desktopeditors

      # Claude Code
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
      nodejs
      uv # fast Python package manager
      playwright-mcp

      # Hyprland tools
      grimblast # screenshot tool
      cliphist # clipboard history manager
      brightnessctl # screen brightness control
      playerctl # media player control
      swww # wallpaper daemon
      thunar # file manager
      thunar-volman # removable media management for thunar
      thunar-archive-plugin # archive support for thunar
      networkmanager_dmenu # network manager rofi menu

      # Utilities
      lxqt.lxqt-policykit # authentication agent
      pavucontrol # audio volume control
      libnotify # desktop notifications (notify-send)
      overskride # Bluetooth GUI manager

      # Media
      mpv # video player

      # Notes
      obsidian

      # Time tracking
      python313Packages.toggl-cli
      uair # pomodoro timer

      # Proton
      proton-pass # password manager
      proton-pass-cli # password manager CLI
      protonmail-bridge-gui # email bridge for desktop clients
      protonvpn-gui # VPN client

      # Email client
      thunderbird

      # Google alternatives
      freetube # private YouTube client
      spotube # Spotify client without premium

      # Password manager
      keepassxc # offline password manager with autotype

      # Sync
      syncthing # P2P file sync between devices
    ]
    ++ [
      # External flake packages
    ];

  services.syncthing.enable = true;
}
