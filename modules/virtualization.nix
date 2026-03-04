{ ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
}
