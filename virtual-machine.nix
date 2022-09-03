{
  config,
  pkgs,
  ...
}: {
  fileSystems."/".label = "fuck-off-flake-check";
  boot.loader.grub.devices = ["/"];

  documentation.nixos.enable = false;
  users.users.vm.initialPassword = "vm";
  users.users.vm.isNormalUser = true;
  services.xserver.enable = true;
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.desktopManager.budgie.appletPackages = with pkgs.budgieApplets; [budgie-trash-applet budgie-app-launcher];
  services.xserver.displayManager.lightdm.greeters.slick.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vm";
  system.stateVersion = "22.11";
}
