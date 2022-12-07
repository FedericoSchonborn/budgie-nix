{pkgs, ...}: let
  corePackages = rec {
    budgie-backgrounds = pkgs.callPackage ./budgie-backgrounds/default.nix {};
    budgie-control-center = pkgs.callPackage ./budgie-control-center/default.nix {};
    budgie-desktop = pkgs.callPackage ./budgie-desktop {inherit budgie-screensaver;};
    budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view/default.nix {};
    budgie-desktop-with-applets = pkgs.callPackage ./budgie-desktop/wrapper.nix {inherit budgie-desktop;};
    budgie-screensaver = pkgs.callPackage ./budgie-screensaver {};
    budgie-gsettings-overrides = pkgs.callPackage ./budgie-gsettings-overrides {inherit budgie-desktop budgie-desktop-view;};
  };

  # Third-party applets
  appletPackages = {
    budgie-trash-applet = pkgs.callPackage ./budgie-trash-applet/default.nix {inherit (corePackages) budgie-desktop;};
  };

  # Budgie Extras
  extrasPackages = import ./budgie-extras {
    inherit pkgs;
    inherit (corePackages) budgie-desktop;
  };

  # Extra themes
  themePackages = {
    pocillo-gtk-theme = pkgs.callPackage ./pocillo-gtk-theme/default.nix {};
  };
in
  corePackages // appletPackages // extrasPackages // themePackages
