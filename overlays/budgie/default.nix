final: prev: let
  packages = import ../packages;
in rec {
  # Budgie Desktop
  budgie.budgie-backgrounds = packages.budgie-backgrounds.${prev.system};
  budgie.budgie-control-center = packages.budgie-control-center.${prev.system};
  budgie.budgie-desktop = packages.budgie-desktop.${prev.system};
  budgie.budgie-desktop-view = packages.budgie-desktop-view.${prev.system};
  budgie.budgie-screensaver = packages.budgie-screensaver.${prev.system};

  # Applets
  budgieApplets.budgie-trash-applet = packages.budgie-trash-applet.${prev.system};
}
