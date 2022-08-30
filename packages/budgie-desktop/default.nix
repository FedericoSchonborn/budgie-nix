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

stdenv.mkDerivation rec {
  pname = "budgie-desktop";
  version = "10.6.3";

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "38cfd479d1bbdff30f8c18158a8ba6336cc67234d7504c3fbefc05027eed2d4e";
  };

  patches = [
    ./0001-Add-missing-gio-unix-2.0-dependencies.patch
  ];

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
