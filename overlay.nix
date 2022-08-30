final: prev:

rec {
  budgie-control-center = prev.callPackage ./packages/budgie-control-center { };
  budgie-desktop = prev.callPackage ./packages/budgie-desktop {
    inherit budgie-screensaver;
  };
  budgie-desktop-view = prev.callPackage ./packages/budgie-desktop-view { };
  budgie-screensaver = prev.callPackage ./packages/budgie-screensaver { };
}
