{ ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Workaround: virt-secret-init-encryption.service hardcodes /usr/bin/sh
  # which doesn't exist on NixOS, causing activation failures
  systemd.services.virt-secret-init-encryption.enable = false;

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
}
