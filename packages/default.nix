{pkgs, ...}: let
  budgie-screensaver = pkgs.callPackage ./budgie-screensaver.nix {};
  budgie-desktop = pkgs.callPackage ./budgie-desktop.nix {inherit budgie-screensaver;};

  budgieExtras = import ./budgie-extras {inherit pkgs budgie-desktop;};
in
  rec {
    budgie-backgrounds = pkgs.callPackage ./budgie-backgrounds.nix {};
    budgie-control-center = pkgs.callPackage ./budgie-control-center.nix {};
    budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view.nix {};

    # Third-party applets
    budgie-trash-applet = pkgs.callPackage ./budgie-trash-applet.nix {inherit budgie-desktop;};
  }
  // budgieExtras
