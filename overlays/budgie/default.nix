final: prev: let
  packages = import ../../packages {inherit (prev) pkgs;};
in rec {
  # Budgie Desktop
  budgie.budgie-backgrounds = packages.budgie-backgrounds;
  budgie.budgie-control-center = packages.budgie-control-center;
  budgie.budgie-desktop = packages.budgie-desktop;
  budgie.budgie-desktop-view = packages.budgie-desktop-view;
  budgie.budgie-screensaver = packages.budgie-screensaver;

  # Applets
  budgieApplets.budgie-trash-applet = packages.budgie-trash-applet;
}
