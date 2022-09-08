{pkgs, ...}: let
  budgie-screensaver = pkgs.callPackage ./budgie-screensaver.nix {};
  budgie-desktop = pkgs.callPackage ./budgie-desktop {inherit budgie-screensaver;};
in
  rec {
    inherit budgie-screensaver budgie-desktop;

    budgie-backgrounds = pkgs.callPackage ./budgie-backgrounds.nix {};
    budgie-control-center = pkgs.callPackage ./budgie-control-center.nix {};
    budgie-desktop-with-applets = pkgs.callPackage ./budgie-desktop/wrapper.nix {inherit budgie-desktop;};
    budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view.nix {};

    # Third-party applets
    budgie-trash-applet = pkgs.callPackage ./budgie-trash-applet.nix {inherit budgie-desktop;};
  }
  // (import ./budgie-extras {inherit pkgs budgie-desktop;})
