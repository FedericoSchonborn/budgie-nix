{ self }:

{ lib
, config
, pkgs
, ...
}:

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
      nixpkgs.overlays = [
        self.overlays.budgie
      ];
      services.xserver.displayManager.sessionPackages = [ self.packages.x86_64-linux.budgie-desktop ];
      environment.systemPackages = with pkgs;[
        budgie-desktop
        budgie-desktop-view
        budgie-control-center
        budgie-screensaver
        gnome.gnome-session
      ];
    })
  ];
}
