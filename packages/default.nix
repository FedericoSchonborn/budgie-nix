{ pkgs, ... }:

rec {
  budgie-control-center = pkgs.callPackage ./budgie-control-center { };
  budgie-desktop = pkgs.callPackage ./budgie-desktop {
    inherit budgie-screensaver;
  };
  budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view { };
  budgie-screensaver = pkgs.callPackage ./budgie-screensaver { };
}
