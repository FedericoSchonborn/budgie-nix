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

    environment.systemPackages = with pkgs;
      [
        # Budgie Desktop.
        budgie.budgie-backgrounds
        budgie.budgie-desktop
        budgie.budgie-desktop-view
        budgie.budgie-control-center
        budgie.budgie-screensaver

        # Create user directories.
        xdg-user-dirs

        # Required by the Budgie Desktop session.
        gnome.gnome-session

        # Required by Budgie Menu.
        gnome-menus
      ]
      ++ cfg.appletPackages
      ++ (
        # Network Manager applet.
        optional config.networking.networkmanager.enable networkmanagerapplet
      );

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

    # Required by Budgie Desktop.
    security.polkit.enable = true;

    # Required by Budgie Screensaver.
    security.pam.services.budgie-screensaver = {};
  };
}
