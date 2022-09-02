final: prev: let
  packages = import ./packages.nix {inherit (prev) pkgs;};
in {
  # Budgie Desktop
  budgie.budgie-backgrounds = packages.budgie-backgrounds;
  budgie.budgie-control-center = packages.budgie-control-center;
  budgie.budgie-desktop = packages.budgie-desktop;
  budgie.budgie-desktop-view = packages.budgie-desktop-view;
  budgie.budgie-screensaver = packages.budgie-screensaver;

  # Applets
  budgieApplets.budgie-trash-applet = packages.budgie-trash-applet;
}
