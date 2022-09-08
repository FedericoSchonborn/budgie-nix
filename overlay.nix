{packages, ...}: final: prev: {
  # Budgie Desktop
  budgie.budgie-backgrounds = packages.${prev.system}.budgie-backgrounds;
  budgie.budgie-control-center = packages.${prev.system}.budgie-control-center;
  budgie.budgie-desktop = packages.${prev.system}.budgie-desktop;
  budgie.budgie-desktop-with-applets = packages.${prev.system}.budgie-desktop-with-applets;
  budgie.budgie-desktop-view = packages.${prev.system}.budgie-desktop-view;
  budgie.budgie-screensaver = packages.${prev.system}.budgie-screensaver;

  # Third-party applets
  budgieApplets.budgie-trash-applet = packages.${prev.system}.budgie-trash-applet;

  # Budgie Extras
  budgieApplets.budgie-app-launcher = packages.${prev.system}.budgie-app-launcher;
  budgieApplets.budgie-applications-menu = packages.${prev.system}.budgie-applications-menu;
  budgieApplets.budgie-brightness-controller = packages.${prev.system}.budgie-brightness-controller;
  budgieApplets.budgie-fuzzyclock = packages.${prev.system}.budgie-fuzzyclock;
  budgieApplets.budgie-kangaroo = packages.${prev.system}.budgie-kangaroo;
  budgieApplets.budgie-keyboard-autoswitch = packages.${prev.system}.budgie-keyboard-autoswitch;
  budgieApplets.budgie-network-manager = packages.${prev.system}.budgie-network-manager;
  budgieApplets.budgie-quicknote = packages.${prev.system}.budgie-quicknote;
  budgieApplets.budgie-rotation-lock = packages.${prev.system}.budgie-rotation-lock;
  budgieApplets.budgie-trash = packages.${prev.system}.budgie-trash;
  budgieApplets.budgie-workspace-stopwatch = packages.${prev.system}.budgie-workspace-stopwatch;
}
