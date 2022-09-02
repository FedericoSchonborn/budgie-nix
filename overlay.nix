{packages, ...}: final: prev: {
  # Budgie Desktop
  budgie.budgie-backgrounds = packages.${prev.system}.budgie-backgrounds;
  budgie.budgie-control-center = packages.${prev.system}.budgie-control-center;
  budgie.budgie-desktop = packages.${prev.system}.budgie-desktop;
  budgie.budgie-desktop-view = packages.${prev.system}.budgie-desktop-view;
  budgie.budgie-screensaver = packages.${prev.system}.budgie-screensaver;

  # Applets
  budgieApplets.budgie-trash-applet = packages.${prev.system}.budgie-trash-applet;
}
