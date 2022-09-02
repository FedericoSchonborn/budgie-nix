{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.budgie-desktop-view;
in {
  options.programs.budgie-desktop-view = {
    enable = mkEnableOption "Budgie Desktop View";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [budgie.budgie-desktop-view];
    # Budgie Desktop Settings crashes without the GSettings schemas.
    services.xserver.desktopManager.budgie.sessionPath = with pkgs; [budgie.budgie-desktop-view];
  };
}
