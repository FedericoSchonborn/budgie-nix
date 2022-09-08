{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.xserver.desktopManager.budgie;
in {
  options.services.xserver.desktopManager.budgie = {
    enable = mkEnableOption "Budgie Desktop";

    sessionPath = mkOption {
      # TODO: Description.
      type = with types; listOf package;
      default = [];
      example = literalExpression "[ pkgs.budgie.budgie-desktop-view ]";
    };

    appletPackages = mkOption {
      # TODO: Better description.
      description = "Budgie Desktop Applets";
      type = with types; listOf package;
      default = [];
      example = literalExpression "[ pkgs.budgieApplets.budgie-trash-applet ]";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.sessionPackages = with pkgs; [budgie.budgie-desktop];

    environment.extraInit = ''
      ${concatMapStrings (p: ''
          if [ -d "${p}/share/gsettings-schemas/${p.name}" ]; then
            export XDG_DATA_DIRS=$XDG_DATA_DIRS''${XDG_DATA_DIRS:+:}${p}/share/gsettings-schemas/${p.name}
          fi
          if [ -d "${p}/lib/girepository-1.0" ]; then
            export GI_TYPELIB_PATH=$GI_TYPELIB_PATH''${GI_TYPELIB_PATH:+:}${p}/lib/girepository-1.0
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH''${LD_LIBRARY_PATH:+:}${p}/lib
          fi
        '')
        cfg.sessionPath}
    '';

    environment.systemPackages = with pkgs;
      [
        # Budgie Desktop.
        budgie.budgie-backgrounds
        (budgie.budgie-desktop-with-applets.override {
          applets = cfg.appletPackages;
        })
        budgie.budgie-control-center
        budgie.budgie-screensaver

        # Create user directories.
        xdg-user-dirs

        # Required by the Budgie Desktop session.
        gnome.gnome-session

        # Required by Budgie Menu.
        gnome-menus
      ]
      ++ (
        # Network Manager applet.
        optional config.networking.networkmanager.enable networkmanagerapplet
      );

    # Enable Budgie Desktop View by default.
    programs.budgie-desktop-view.enable = mkDefault true;

    # Required by backgrounds.
    environment.pathsToLink = [
      "/share"
    ];

    # Required by the Budgie Desktop session.
    programs.dconf.enable = true;

    # Required by Budgie Control Center.
    hardware.bluetooth.enable = mkDefault true;
    networking.networkmanager.enable = mkDefault true;
    services.colord.enable = mkDefault true;
    services.dbus.enable = true;
    services.dbus.packages = with pkgs; [budgie.budgie-control-center];

    # Required by Budgie Polkit Dialog.
    security.polkit.enable = true;

    # Required by Budgie Screensaver.
    security.pam.services.budgie-screensaver = {};
  };
}
