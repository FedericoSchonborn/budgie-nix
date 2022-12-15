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
    nixos-background = pkgs.nixos-artwork.wallpapers.simple-dark-gray;
    inherit (cfg) extraGSettingsOverrides extraGSettingsOverridePackages;
  };
in {
  options = {
    services.xserver.desktopManager.budgie = {
      enable = mkEnableOption "Budgie desktop";

      sessionPath = mkOption {
        # TODO: Description.
        type = with types; listOf package;
        default = [];
        example = literalExpression "[ pkgs.budgie.budgie-desktop-view ]";
      };

      pluginPackages = mkOption {
        description = "Plugins to be installed with the Budgie desktop";
        type = with types; listOf package;
        default = [];
        example = literalExpression "[ pkgs.budgiePlugins.budgie-trash-applet ]";
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
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };

      iconTheme = mkDefault {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = mkDefault {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
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
        (budgie.budgie-desktop-with-plugins.override {
          plugins = cfg.pluginPackages;
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
      ]
      # Packages marked with [*] need to be patched to show up on Budgie.
      ++ (utils.removePackagesByName [
          mate.caja # [*]
          mate.eom
          mate.pluma
          mate.atril
          mate.engrampa
          mate.mate-calc
          mate.mate-utils # [*]
          mate.mate-terminal
          mate.mate-power-manager # [*]
          mate.mate-system-monitor # [*]
          vlc
          materia-theme
          papirus-icon-theme
          bibata-cursors
          nixos-gsettings-overrides
        ]
        config.environment.budgie.excludePackages);

    # Enable NM Applet (non-Indicator) if NetworkManager is enabled.
    programs.nm-applet.enable = true;
    programs.nm-applet.indicator = false;

    # Enable Budgie Desktop View by default.
    programs.budgie-desktop-view.enable = mkDefault true;

    # Required by backgrounds and plugins.
    environment.pathsToLink = [
      "/share" # TODO: https://github.com/NixOS/nixpkgs/issues/47173
    ];

    environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = "${nixos-gsettings-overrides}/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";

    fonts.fonts = with pkgs; [
      noto-fonts
      hack-font
    ];

    fonts.fontconfig.defaultFonts = {
      sansSerif = mkDefault ["Noto Sans"];
      monospace = mkDefault ["Hack"];
    };

    qt5 = {
      enable = mkDefault true;
      style = mkDefault "gtk2";
      platformTheme = mkDefault "gtk2";
    };

    services.xserver.updateDbusEnvironment = true;

    # Reference: services.gnome.core-os-utilites
    # Required by the Budgie Desktop session.
    programs.dconf.enable = true;
    # Required by Budgie Polkit Dialog.
    security.polkit.enable = true;
    services.accounts-daemon.enable = true;
    services.gnome.gnome-keyring.enable = true;
    # Required by Budgie Control Center.
    hardware.bluetooth.enable = mkDefault true;
    networking.networkmanager.enable = mkDefault true;
    services.colord.enable = mkDefault true;

    # VTE integration for MATE Terminal.
    programs.bash.vteIntegration = true;
    programs.zsh.vteIntegration = true;

    services.dbus.enable = true;
    services.dbus.packages = with pkgs; [
      budgie.budgie-control-center
    ];

    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    # Required by Budgie Screensaver.
    security.pam.services.budgie-screensaver = {};
  };
}
