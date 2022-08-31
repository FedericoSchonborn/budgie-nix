_: super:

rec {
  # Budgie Desktop
  budgie.budgie-backgrounds = super.callPackage ../../packages/budgie-backgrounds { };
  budgie.budgie-control-center = super.callPackage ../../packages/budgie-control-center { };
  budgie.budgie-desktop = super.callPackage ../../packages/budgie-desktop { inherit (budgie) budgie-screensaver; };
  budgie.budgie-desktop-view = super.callPackage ../../packages/budgie-desktop-view { };
  budgie.budgie-screensaver = super.callPackage ../../packages/budgie-screensaver { };

  # Applets
  budgieApplets.budgie-trash-applet = super.callPackage ./budgie-trash-applet { inherit (budgie) budgie-desktop; };
}
