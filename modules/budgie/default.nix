{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.xserver.desktopManager.budgie;
in
{
  options.services.xserver.desktopManager.budgie = {
    enable = mkEnableOption "Budgie Desktop";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      services.xserver.displayManager.sessionPackages = with pkgs; [ budgie-desktop ];

      environment.systemPackages = with pkgs; [
        # Budgie Desktop.
        budgie-backgrounds
        budgie-desktop
        budgie-desktop-view
        budgie-control-center
        budgie-screensaver

        # Create user directories.
        xdg-user-dirs

        # Required by the Budgie Desktop session.
        gnome.gnome-session

        # Required by Budgie Menu.
        gnome-menus
      ] ++ (
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
      services.dbus.packages = with pkgs; [ budgie-control-center ];

      # Required by Budgie Desktop.
      security.polkit.enable = true;

      # Required by Budgie Screensaver.
      security.pam.services.budgie-screensaver = { };
    })
  ];
}
