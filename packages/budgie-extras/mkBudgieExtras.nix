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
    fetchFromGitHub,
    appstream,
    glib,
    gnome,
    gtk3,
    intltool,
    json-glib,
    libgee,
    libhandy,
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
      version = "1.5.0";

      src = fetchFromGitHub {
        owner = "UbuntuBudgie";
        repo = "budgie-extras";
        rev = "v${version}";
        fetchSubmodules = true;
        sha256 = "sha256-FBtWZxHgwTHd38aekB+X4Qx+WlTENnOOzDztn/DPtwQ=";
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
        libhandy
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
