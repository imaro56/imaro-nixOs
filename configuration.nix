{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./virtualization.nix
  ];

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Nix cleanup
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };


  # Boot
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;

    systemd-boot = {
      enable = true;
      configurationLimit = 3;

      windows = {
        "windows" =
          let
            # To determine the name of the windows boot drive, boot into edk2 first, then run
            # `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
            # which alias corresponds to which EFI partition.
            boot-drive = "FS0";
          in
          {
            title = "Windows";
            efiDeviceHandle = boot-drive;
            sortKey = "y_windows";
          };
      };

      edk2-uefi-shell.enable = true;
      edk2-uefi-shell.sortKey = "z_edk2";
    };
  };

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  # SSD (Samsung 990 Pro NVMe)
  fileSystems."/".options = [ "noatime" ];
  services.fstrim.enable = true;
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';
  services.avahi.enable = false;
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.vfs_cache_pressure" = 50;
    "vm.page-cluster" = 0; # read single pages from zram (better for compressed swap)
    "net.core.default_qdisc" = "cake"; # better network queuing
    "net.ipv4.tcp_congestion_control" = "bbr"; # faster TCP
    "kernel.nmi_watchdog" = 0; # save CPU cycles
  };

  # Zram (compressed RAM swap - same as Windows memory compression)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Firmware
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;

  # Graphics (NVIDIA PRIME Offload - AMD iGPU primary, NVIDIA dGPU on demand)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };



  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Users
  users.users.imaro56 = {
    isNormalUser = true;
    description = "imaro56";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;

  # Lid
  services.logind.settings.Login.HandleLidSwitch = "suspend";

  # Display & Input
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us,ua";
    options = "grp:caps_toggle";
  };

  # Greeter
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "greeter";
    };
  };

  # Swap Escape and CapsLock at input level (before XKB)
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "escape";
        escape = "capslock";
      };
    };
  };

  # Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # System Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    jq # json processor
    wl-clipboard # clipboard
  ];

  # Services
  services.gvfs.enable = true;
  services.printing.enable = false;
  systemd.services.ModemManager.enable = false;
  programs.fish.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  programs.nix-ld.enable = true;
  programs.nh = {
    enable = true;
    flake = "/home/imaro56/nixos-config";
  };

  system.stateVersion = "25.11";
}
