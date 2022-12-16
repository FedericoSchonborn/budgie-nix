{pkgs, ...}: let
  corePackages = rec {
    budgie-backgrounds = pkgs.callPackage ./budgie-backgrounds/default.nix {};
    budgie-control-center = pkgs.callPackage ./budgie-control-center/default.nix {};
    budgie-desktop = pkgs.callPackage ./budgie-desktop {inherit budgie-screensaver;};
    budgie-desktop-view = pkgs.callPackage ./budgie-desktop-view/default.nix {};
    budgie-desktop-with-plugins = pkgs.callPackage ./budgie-desktop/wrapper.nix {inherit budgie-desktop;};
    budgie-screensaver = pkgs.callPackage ./budgie-screensaver {};
    budgie-gsettings-overrides = pkgs.callPackage ./budgie-gsettings-overrides {inherit budgie-desktop budgie-desktop-view;};
  };

  # Third-party plugins
  pluginPackages = {
    budgie-trash-applet = pkgs.callPackage ./budgie-trash-applet/default.nix {inherit (corePackages) budgie-desktop;};
  };

  # Budgie Extras
  extrasPackages = import ./budgie-extras {
    inherit pkgs;
    inherit (corePackages) budgie-desktop;
  };

  # Pocillo themes
  pocilloPackages = {
    pocillo-gtk-theme = pkgs.callPackage ./pocillo-gtk-theme/default.nix {};
  };
in
  corePackages // pluginPackages // extrasPackages // pocilloPackages
