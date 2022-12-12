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
  };

  environment.systemPackages = with pkgs; [
    # Web Browser
    firefox
    # Mail/Calendar
    thunderbird
  ];

  users.users.demo = {
    description = "Demo";
    password = "demo";
    isNormalUser = true;
  };

  system.stateVersion = "23.05";
}
