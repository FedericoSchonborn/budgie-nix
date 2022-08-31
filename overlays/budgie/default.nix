_: super:

rec {
  budgie-control-center = super.callPackage ../../packages/budgie-control-center { };
  budgie-desktop = super.callPackage ../../packages/budgie-desktop { inherit budgie-screensaver; };
  budgie-desktop-view = super.callPackage ../../packages/budgie-desktop-view { };
  budgie-screensaver = super.callPackage ../../packages/budgie-screensaver { };
}
