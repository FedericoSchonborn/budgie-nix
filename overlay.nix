{packages, ...}: final: prev: {
  # Budgie Desktop
  budgie.budgie-backgrounds = packages.${prev.system}.budgie-backgrounds;
  budgie.budgie-control-center = packages.${prev.system}.budgie-control-center;
  budgie.budgie-desktop = packages.${prev.system}.budgie-desktop;
  budgie.budgie-desktop-view = packages.${prev.system}.budgie-desktop-view;
  budgie.budgie-screensaver = packages.${prev.system}.budgie-screensaver;

  # Third-party applets
  budgieApplets.budgie-trash-applet = packages.${prev.system}.budgie-trash-applet;

  # Budgie Extras
  budgieApplets.budgie-app-launcher = packages.${prev.system}.budgie-app-launcher;
  budgieApplets.budgie-app-launcher = pacakges.${prev.system}.budgie-app-launcher;
  budgieApplets.budgie-applications-menu = pacakges.${prev.system}.budgie-applications-menu;
  budgieApplets.budgie-brightness-controller = pacakges.${prev.system}.budgie-brightness-controller;
  budgieApplets.budgie-fuzzyclock = pacakges.${prev.system}.budgie-fuzzyclock;
  budgieApplets.budgie-kangaroo = pacakges.${prev.system}.budgie-kangaroo;
  budgieApplets.budgie-keyboard-autoswitch = pacakges.${prev.system}.budgie-keyboard-autoswitch;
  budgieApplets.budgie-network-manager = pacakges.${prev.system}.budgie-network-manager;
  budgieApplets.budgie-quicknote = pacakges.${prev.system}.budgie-quicknote;
  budgieApplets.budgie-rotation-lock = pacakges.${prev.system}.budgie-rotation-lock;
  budgieApplets.budgie-trash = pacakges.${prev.system}.budgie-trash;
  budgieApplets.budgie-workspace-stopwatch = pacakges.${prev.system}.budgie-workspace-stopwatch;
}
