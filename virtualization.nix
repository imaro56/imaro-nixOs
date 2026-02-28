{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.imaro56.extraGroups = [ "libvirtd" ];
}
