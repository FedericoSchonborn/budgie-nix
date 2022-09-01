{pkgs, ...}: rec {
  budgie-backgrounds = pkgs.callPackage ./budgie-backgrounds {};
  budgie-control-center = pkgs.callPackage ./budgie-control-center {};
  budgie-desktop = pkgs.callPackage ./budgie-desktop {inherit budgie-screensaver;};
  budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view {};
  budgie-screensaver = pkgs.callPackage ./budgie-screensaver {};
  budgie-trash-applet = pkgs.callPackage ./budgie-trash-applet {inherit budgie-desktop;};
}
