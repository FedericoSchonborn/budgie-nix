{
  config,
  pkgs,
  ...
}: {
  documentation.nixos.enable = false;
  users.users.vm.initialPassword = "vm";
  users.users.vm.isNormalUser = true;
  services.xserver.enable = true;
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.desktopManager.budgie.appletPackages = [pkgs.budgieApplets.budgie-trash-applet];
  services.xserver.displayManager.lightdm.greeters.slick.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vm";
  system.stateVersion = "22.11";
}
