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
        [com.solus-project.icon-tasklist:Budgie]
        pinned-launchers=['firefox.desktop', 'nixos-manual.desktop', 'mate-terminal.desktop', 'nemo.desktop', 'gparted.desktop', 'io.calamares.calamares.desktop']
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

  system.stateVersion = "23.05";
}
