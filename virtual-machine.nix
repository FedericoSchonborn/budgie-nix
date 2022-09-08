{pkgs, ...}: {
  fileSystems."/".label = "fuck-off-flake-check";
  boot.loader.grub.devices = ["/"];

  documentation.nixos.enable = false;
  services.xserver.desktopManager.budgie.appletPackages = with pkgs.budgieApplets; [budgie-trash-applet budgie-app-launcher];
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vm";
  services.xserver.displayManager.lightdm.greeters.slick.enable = true;
  services.xserver.enable = true;
  users.users.vm.initialPassword = "vm";
  users.users.vm.isNormalUser = true;
  system.stateVersion = "22.11";
}
