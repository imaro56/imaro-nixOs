{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix.nix
    ../../modules/nvidia.nix
    ../../modules/audio.nix
    ../../modules/networking.nix
    ../../modules/hyprland.nix
    ../../modules/virtualization.nix
    ../../modules/gaming.nix
  ];

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

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvme_core.default_ps_max_latency_us=0"
    "amdgpu.dcdebugmask=0x10"
  ];

  # SSD (Samsung 990 Pro NVMe)
  fileSystems."/".options = [ "noatime" ];
  services.fstrim.enable = true;
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.vfs_cache_pressure" = 50;
    "vm.page-cluster" = 0;
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "kernel.nmi_watchdog" = 0;
  };

  # Zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Hostname
  networking.hostName = "imaro56";

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

  # Firmware
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;

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
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
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

  # System Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    jq
    wl-clipboard
  ];

  # Services
  services.gvfs.enable = true;
  services.printing.enable = false;
  systemd.services.ModemManager.enable = false;
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  programs.nh = {
    enable = true;
    flake = "/home/imaro56/nixos-config";
  };

  system.stateVersion = "25.11";
}
