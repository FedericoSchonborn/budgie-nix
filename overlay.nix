{packages, ...}: final: prev: {
  budgie = {
    # Budgie Desktop
    inherit
      (packages.${prev.system})
      budgie-backgrounds
      budgie-control-center
      budgie-desktop
      budgie-desktop-with-plugins
      budgie-desktop-view
      budgie-screensaver
      budgie-gsettings-overrides
      ;
  };

  budgiePlugins = {
    # Third-party applets
    inherit
      (packages.${prev.system})
      budgie-trash-applet
      budgie-screenshot-applet
      ;

    # Budgie Extras
    inherit
      (packages.${prev.system})
      budgie-app-launcher
      budgie-applications-menu
      budgie-brightness-controller
      budgie-fuzzyclock
      budgie-kangaroo
      budgie-keyboard-autoswitch
      budgie-network-manager
      budgie-quicknote
      budgie-rotation-lock
      budgie-trash
      budgie-workspace-stopwatch
      ;
  };

  # Pocillo themes
  inherit
    (packages.${prev.system})
    pocillo-gtk-theme
    ;
}
