_: super:

rec {
  budgie.budgie-backgrounds = super.callPackage ../../packages/budgie-backgrounds { };
  budgie.budgie-control-center = super.callPackage ../../packages/budgie-control-center { };
  budgie.budgie-desktop = super.callPackage ../../packages/budgie-desktop { inherit (budgie) budgie-screensaver; };
  budgie.budgie-desktop-view = super.callPackage ../../packages/budgie-desktop-view { };
  budgie.budgie-screensaver = super.callPackage ../../packages/budgie-screensaver { };
}
