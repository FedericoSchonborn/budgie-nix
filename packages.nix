{ pkgs
, ...
}:

rec {
  budgie-control-center = pkgs.callPackage ./packages/budgie-control-center { };
  budgie-desktop = pkgs.callPackage ./packages/budgie-desktop {
    inherit budgie-screensaver;
  };
  budgie-desktop-view = pkgs.callPackage ./packages/budgie-desktop-view { };
  budgie-screensaver = pkgs.callPackage ./packages/budgie-screensaver { };
}
