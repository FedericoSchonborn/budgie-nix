{ stdenv
, fetchurl
, meson
, ninja
, pkg-config
, libX11
, glib
, dbus-glib
, gtk3
, gnome-desktop
, systemd
, libgnomekbd
, linux-pam
, intltool
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "budgie-screensaver";
  version = "5.0.2";

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "01d204947159f9fedc8e7511c72bf916e6244371262892c8fe004ce9e56f7bb0";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    intltool
    systemd
    wrapGAppsHook
  ];

  buildInputs = [
    libX11
    glib
    dbus-glib
    gtk3
    gnome-desktop
    libgnomekbd
    linux-pam
  ];
}
