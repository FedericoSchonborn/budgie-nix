{
  lib,
  runCommand,
  budgie-desktop,
  glib,
  gsettings-desktop-schemas,
  nixos-background ? null,
  extraGSettingsOverrides ? "",
  extraGSettingsOverridePackages ? [],
  ...
}: let
  inherit (lib) concatMapStringsSep;

  gsettingsOverrides =
    ''
      [org.gnome.desktop.background:Budgie]
      picture-uri="file://${nixos-background.gnomeFilePath}"

      [org.gnome.desktop.screensaver:Budgie]
      picture-uri="file://${nixos-background.gnomeFilePath}"

      [org.gnome.desktop.interface:Budgie]
      gtk-theme="Qogir"
      icon-theme="Qogir"
      cursor-theme="Qogir"
      font-name="Noto Sans 10"
      document-font-name="Noto Sans 10"
      monospace-font-name="Hack 10"
      font-antialiasing="rgba"
      font-hinting="slight"

      [com.solus-project.budgie-panel:Budgie]
      dark-theme=false

      [com.solus-project.icon-tasklist:Budgie]
      pinned-launchers=['nemo.desktop', 'firefox.desktop', 'xplayer.desktop']
    ''
    + extraGSettingsOverrides;

  gsettingsOverridePackages =
    [
      budgie-desktop
      gsettings-desktop-schemas
    ]
    ++ extraGSettingsOverridePackages;
in
  runCommand "budgie-gsettings-overrides" {preferLocalBuild = true;} ''
    data_dir="$out/share/gsettings-schemas/nixos-gsettings-overrides"
    schema_dir="$data_dir/glib-2.0/schemas"

    mkdir -p "$schema_dir"

    ${concatMapStringsSep "\n" (pkg: "cp -rf \"${glib.getSchemaPath pkg}\"/*.xml \"${glib.getSchemaPath pkg}\"/*.gschema.override \"$schema_dir\"") gsettingsOverridePackages}

    chmod -R a+w "$data_dir"

    cat - > "$schema_dir/nixos-defaults.gschema.override" <<- EOF
    ${gsettingsOverrides}
    EOF

    ${glib.dev}/bin/glib-compile-schemas --strict "$schema_dir"
  ''
