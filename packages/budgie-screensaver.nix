{ stdenv, fetchurl, meson, ninja, pkg-config, libX11, glib, dbus-glib, gtk3, gnome-desktop, systemd, libgnomekbd, linux-pam, intltool }:

stdenv.mkDerivation {
  name = "budgie-screensaver";
  src = fetchurl {
    url = https://github.com/BuddiesOfBudgie/budgie-screensaver/releases/download/v5.0.2/budgie-screensaver-v5.0.2.tar.xz;
    sha256 = "01d204947159f9fedc8e7511c72bf916e6244371262892c8fe004ce9e56f7bb0";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    intltool
  ];

  buildInputs = [
    libX11
    glib
    dbus-glib
    gtk3
    gnome-desktop
    systemd
    libgnomekbd
    linux-pam
  ];
}
