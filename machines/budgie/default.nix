{pkgs, ...}: {
  services.xserver = {
    enable = true;
    desktopManager.budgie = {
      enable = true;
      appletPackages = with pkgs.budgieApplets; [budgie-trash-applet];
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "demo";
      };

      lightdm.greeters.slick.enable = true;
    };
  };

  users.users.demo = {
    description = "Demo";
    initialPassword = "demo";
    isNormalUser = true;
  };

  system.stateVersion = "23.05";
}
