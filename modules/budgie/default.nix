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
      environment.systemPackages = with pkgs;[
        budgie-desktop
        budgie-desktop-view
        budgie-control-center
        budgie-screensaver

        # Required by the Budgie Desktop session
        gnome.gnome-session

        # Required by Budgie Menu
        gnome-menus
      ];
    })
  ];
}
