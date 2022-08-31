{ stdenv
, fetchurl
, meson
, ninja
, pkg-config
, vala
, budgie-screensaver
, gtk3
, libpeas
, libuuid
, ibus
, libnotify
, gnome-desktop
, gnome
, libwnck
, accountsservice
, intltool
, libpulseaudio
, alsa-lib
, sassc
, polkit
, graphene
, gnome-menus
, upower
, gtk-doc
, glib
, libGL
, mesa
, docbook-xsl-nons
, wrapGAppsHook
}:

let
  pname = "budgie-desktop";
  version = "10.6.4";
in

stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "d3VpnqZNcxfkAEt1HM1aseON8XLOF6vCQbiiK7McHNs=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    intltool
    gtk-doc
    docbook-xsl-nons
    wrapGAppsHook
  ];

  buildInputs = [
    budgie-screensaver
    gtk3
    libpeas
    libuuid
    ibus
    libnotify
    gnome-desktop
    gnome.gnome-settings-daemon
    libwnck
    accountsservice
    libpulseaudio
    alsa-lib
    sassc
    polkit
    graphene
    gnome.mutter
    gnome-menus
    gnome.gnome-bluetooth_1_0
    upower
    glib
    libGL
    mesa
  ];

  passthru.providedSessions = [
    "budgie-desktop"
  ];
}
