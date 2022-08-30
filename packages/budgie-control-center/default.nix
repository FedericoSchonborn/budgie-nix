{ stdenv
, fetchurl
, meson
, ninja
, pkg-config
, glib
, libpulseaudio
, gtk3
, libhandy
, accountsservice
, colord
, gnome-desktop
, gnome
, gnome-online-accounts
, libxml2
, upower
, libgudev
, libepoxy
, gcr
, libpwquality
, polkit
, gettext
, clutter
, clutter-gtk
, ibus
, networkmanager
, libnma
, modemmanager
, libwacom
, colord-gtk
, udisks
, libgtop
, samba
, libsecret
, gsound
, krb5
}:

stdenv.mkDerivation rec {
  pname = "budgie-control-center";
  version = "1.1.0";

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-${version}.tar.xz";
    sha256 = "1d0de48749c10e43f1e66b3a95557118cbd6815b659c4881f040d324dc7a8abc";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    glib
    gettext
    polkit # For Polkit ITS
  ];

  buildInputs = [
    gtk3
    libhandy
    libpulseaudio
    accountsservice
    colord
    gnome-desktop
    gnome.gnome-settings-daemon
    gnome-online-accounts
    libxml2
    upower
    libgudev
    libepoxy
    gcr
    libpwquality
    gnome.cheese
    clutter
    clutter-gtk
    ibus
    networkmanager
    libnma
    modemmanager
    gnome.gnome-bluetooth_1_0
    libwacom
    colord-gtk
    udisks
    libgtop
    samba
    libsecret
    gsound
    krb5
  ];
}