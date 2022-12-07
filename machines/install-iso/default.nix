{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  isoImage.edition = "budgie";

  services.xserver = {
    enable = true;

    desktopManager.budgie = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.buddiesofbudgie.budgie-desktop-view]
        show=true
        show-active-mounts=false
        show-home-folder=false
        show-trash-folder=false
      '';
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "nixos";
      };

      lightdm.greeters.slick.enable = true;
    };
  };

  system.activationScripts.installerDesktop = let
    # Comes from documentation.nix when xserver and nixos.enable are true.
    manualDesktopFile = "/run/current-system/sw/share/applications/nixos-manual.desktop";
    homeDir = "/home/nixos/";
    desktopDir = homeDir + "Desktop/";
  in ''
    mkdir -p ${desktopDir}
    chown nixos ${homeDir} ${desktopDir}
    ln -sfT ${manualDesktopFile} ${desktopDir + "nixos-manual.desktop"}
    ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
    ln -sfT ${pkgs.gnome.gnome-terminal}/share/applications/org.gnome.Terminal.desktop ${desktopDir + "org.gnome.Terminal.desktop"}
    ln -sfT ${pkgs.calamares-nixos}/share/applications/io.calamares.calamares.desktop ${desktopDir + "io.calamares.calamares.desktop"}
  '';

  system.stateVersion = "23.05";
}
