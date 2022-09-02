{pkgs, ...}: rec {
  budgie-backgrounds = pkgs.callPackage ./budgie-backgrounds.nix {};
  budgie-control-center = pkgs.callPackage ./budgie-control-center.nix {};
  budgie-desktop = pkgs.callPackage ./budgie-desktop.nix {inherit budgie-screensaver;};
  budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view.nix {};
  budgie-screensaver = pkgs.callPackage ./budgie-screensaver.nix {};
  budgie-trash-applet = pkgs.callPackage ./budgie-trash-applet.nix {inherit budgie-desktop;};
}
