{pkgs, ...}: {
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [
      xterm
    ];

    desktopManager.budgie = {
      enable = true;
      appletPackages = with pkgs.budgieApplets; [
        budgie-trash-applet
      ];
    };

    displayManager.autoLogin = {
      enable = true;
      user = "demo";
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];

  users.users.demo = {
    description = "Demo";
    initialPassword = "demo";
    isNormalUser = true;
  };

  system.stateVersion = "23.05";
}
