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
    environment.systemPackages = with pkgs; [
      # Budgie Desktop Settings crashes without the GSettings schemas.
      budgie.budgie-desktop-view
    ];

    services.xserver.desktopManager.budgie = {
      sessionPath = with pkgs; [
        budgie.budgie-desktop-view
      ];

      extraGSettingsOverrides = ''
        [org.buddiesofbudgie.budgie-desktop-view:Budgie]
        click-policy="double"
      '';

      extraGSettingsOverridePackages = with pkgs; [
        budgie.budgie-desktop-view
      ];
    };
  };
}
