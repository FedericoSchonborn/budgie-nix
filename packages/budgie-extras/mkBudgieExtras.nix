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
    appstream,
    glib,
    gnome,
    gtk3,
    intltool,
    json-glib,
    libgee,
    libhandy_0,
    libnma,
    libnotify,
    libpeas,
    libsoup,
    libwnck,
    meson,
    networkmanager,
    ninja,
    pantheon,
    pkg-config,
    vala,
  }:
    stdenv.mkDerivation rec {
      pname = "budgie-" + name;
      version = "1.4.0";

      src = fetchurl {
        url = "https://github.com/UbuntuBudgie/budgie-extras/releases/download/v${version}/budgie-extras-${version}.tar.xz";
        sha256 = "13mcqmd9ykyc36m3fmi4ns5mj9alqsxfjsj9d5mwk9zs4zs21zlv";
      };

      nativeBuildInputs = [
        glib
        intltool
        meson
        ninja
        pkg-config
        vala
      ];

      buildInputs = [
        appstream
        budgie-desktop
        gnome.gnome-settings-daemon
        gtk3
        json-glib
        libgee
        libhandy_0
        libnma
        libnotify
        libpeas
        libsoup
        libwnck
        networkmanager
        pantheon.granite
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
