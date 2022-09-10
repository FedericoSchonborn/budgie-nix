{pkgs, ...}: let
  corePackages = rec {
    budgie-screensaver = pkgs.callPackage ./budgie-screensaver.nix {};
    budgie-desktop = pkgs.callPackage ./budgie-desktop {inherit budgie-screensaver;};
    budgie-backgrounds = pkgs.callPackage ./budgie-backgrounds.nix {};
    budgie-control-center = pkgs.callPackage ./budgie-control-center.nix {};
    budgie-desktop-with-applets = pkgs.callPackage ./budgie-desktop/wrapper.nix {inherit budgie-desktop;};
    budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view.nix {};
  };

  # Third-party applets
  appletPackages = {
    budgie-trash-applet = pkgs.callPackage ./budgie-trash-applet.nix {inherit (corePackages) budgie-desktop;};
  };

  # Budgie Extras
  extrasPackages = import ./budgie-extras {
    inherit pkgs;
    inherit (corePackages) budgie-desktop;
  };
in
  corePackages // appletPackages // extrasPackages
