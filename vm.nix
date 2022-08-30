{ config
, pkgs
, ...
}:

{
  documentation.nixos.enable = false;
  users.users.vm.initialPassword = "vm";
  users.users.vm.isNormalUser = true;
  services.xserver.enable = true;
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  system.stateVersion = "22.11";
}
