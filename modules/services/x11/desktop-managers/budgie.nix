{
  lib,
  config,
  pkgs,
  utils,
  ...
}:
with lib; let
  cfg = config.services.xserver.desktopManager.budgie;

  nixos-gsettings-overrides = pkgs.budgie.budgie-gsettings-overrides.override {
    nixos-background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray;
    inherit (cfg) extraGSettingsOverrides extraGSettingsOverridePackages;
  };

  notExcluded = pkg: mkDefault (!(elem pkg config.environment.budgie.excludePackages));
in {
  options = {
    services.xserver.desktopManager.budgie = {
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

      extraGSettingsOverrides = mkOption {
        default = "";
        type = types.lines;
        description = "Additional gsettings overrides.";
      };

      extraGSettingsOverridePackages = mkOption {
        default = [];
        type = with types; listOf path;
        description = "List of packages for which gsettings are overridden.";
      };
    };

    environment.budgie.excludePackages = mkOption {
      # TODO: Description.
      type = with types; listOf package;
      default = [];
      example = literalExpression "[ pkgs.gnome-console ]";
    };
  };

  config = mkIf cfg.enable {
    system.nixos-generate-config.desktopConfiguration = [
      ''
        # Enable the Budgie Desktop
        services.xserver.displayManager.lightdm.greeters.slick.enable = true;
        services.xserver.desktopManager.budgie.enable = true;
      ''
    ];

    services.xserver.displayManager.sessionPackages = with pkgs; [
      budgie.budgie-desktop
    ];

    services.xserver.displayManager.lightdm.greeters.slick = {
      enable = true;
      theme = mkDefault {
        name = "Qogir";
        package = pkgs.qogir-theme;
      };

      iconTheme = mkDefault {
        name = "Qogir";
        package = pkgs.qogir-icon-theme;
      };

      cursorTheme = mkDefault {
        name = "Qogir";
        package = pkgs.qogir-icon-theme;
      };
    };

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

        # Provides `gsettings`.
        glib

        # Create user directories.
        xdg-user-dirs

        # Required by the Budgie Desktop session.
        gnome.gnome-session

        # Required by Budgie Menu.
        gnome-menus

        # Required by Budgie Control Center.
        tzdata
      ]
      ++ (utils.removePackagesByName [
          cinnamon.nemo
          cinnamon.xreader
          cinnamon.xviewer
          gnome.file-roller
          gnome.gnome-screenshot
          gnome.gnome-system-monitor
          gnome.gnome-terminal
          xed-editor
          xplayer
          qogir-theme
          qogir-icon-theme
          nixos-gsettings-overrides
        ]
        config.environment.budgie.excludePackages);

    # Default programs.
    programs.file-roller.enable = notExcluded pkgs.gnome.file-roller;

    # Enable NM Applet (non-Indicator) if NetworkManager is enabled.
    programs.nm-applet.enable = true;
    programs.nm-applet.indicator = false;

    # Enable Budgie Desktop View by default.
    programs.budgie-desktop-view.enable = mkDefault true;

    # Required by backgrounds and applets.
    environment.pathsToLink = [
      "/share"
    ];

    environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = "${nixos-gsettings-overrides}/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";

    fonts.fonts = with pkgs; [
      noto-fonts
      hack-font
    ];

    fonts.fontconfig.defaultFonts = {
      emoji = mkDefault ["Noto Emoji Color"];
      monospace = mkDefault ["Hack"];
      sansSerif = mkDefault ["Noto Sans"];
    };

    qt5 = {
      enable = true;
      style = mkDefault "gtk2";
      platformTheme = mkDefault "gtk2";
    };

    services.xserver.updateDbusEnvironment = true;

    # Required by the Budgie Desktop session.
    programs.dconf.enable = true;

    # Required by Budgie Control Center.
    hardware.bluetooth.enable = mkDefault true;
    networking.networkmanager.enable = mkDefault true;
    services.colord.enable = mkDefault true;
    services.dbus.enable = true;
    services.dbus.packages = with pkgs; [
      budgie.budgie-control-center
    ];

    # Required by Budgie Polkit Dialog.
    security.polkit.enable = true;

    # Required by Budgie Screensaver.
    security.pam.services.budgie-screensaver = {};
  };
}
