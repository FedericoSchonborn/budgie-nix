{
  pkgs,
  budgie-desktop,
  ...
}: {
  name,
  flag ? name,
  ...
}:
pkgs.callPackage
({
  lib,
  stdenv,
  fetchurl,
  gnome,
  pantheon,
  meson,
  ninja,
  pkg-config,
  vala,
  intltool,
  glib,
  libpeas,
  gtk3,
  libgee,
  libsoup,
  appstream,
  json-glib,
  libhandy_0,
  libnotify,
  networkmanager,
  libnma,
  libwnck3,
  ...
}: let
  inherit budgie-desktop;

  pname = "budgie-" + name;
  version = "1.4.0";
in
  stdenv.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/UbuntuBudgie/budgie-extras/releases/download/v${version}/budgie-extras-${version}.tar.xz";
      sha256 = "13mcqmd9ykyc36m3fmi4ns5mj9alqsxfjsj9d5mwk9zs4zs21zlv";
    };

    nativeBuildInputs = [
      meson
      ninja
      vala
      pkg-config
      intltool
      glib
    ];

    buildInputs = [
      budgie-desktop
      libpeas
      gtk3
      pantheon.granite
      libgee
      libsoup
      appstream
      json-glib
      libhandy_0
      gnome.gnome-settings-daemon
      libnotify
      networkmanager
      libnma
      libwnck3
    ];

    mesonFlags = [
      "-Dbuild-all=false"
      "-Dbuild-${flag}=true"
    ];

    preInstall = ''
      for file in $(find -name "meson_post_install.py"); do
        patchShebangs $file
      done
    '';

    meta = with lib; {
      # TODO: Descriptions.
      homepage = "https://ubuntubudgie.org/";
      downloadPage = "https://github.com/UbuntuBudgie/budgie-extras/releases";
      platforms = platforms.linux;
      license = licenses.gpl3Plus;
    };
  })
{}
