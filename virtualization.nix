{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
  ];

  users.users.imaro56.extraGroups = [ "libvirtd" ];
}
