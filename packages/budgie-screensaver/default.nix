{
  lib,
  stdenv,
  fetchurl,
  dbus-glib,
  glib,
  gnome-desktop,
  gtk3,
  intltool,
  libgnomekbd,
  libX11,
  linux-pam,
  meson,
  ninja,
  pkg-config,
  systemd,
  wrapGAppsHook,
  xorg,
}:
stdenv.mkDerivation rec {
  pname = "budgie-screensaver";
  version = "5.1.0";

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "VjrD+EVynp5tGE0tvwNqs/Uf8kTCf1sobPy4mswUfww=";
  };

  nativeBuildInputs = [
    intltool
    meson
    ninja
    pkg-config
    systemd
    wrapGAppsHook
  ];

  buildInputs = [
    dbus-glib
    glib
    gnome-desktop
    gtk3
    libgnomekbd
    libX11
    linux-pam
    xorg.libXxf86vm
  ];

  NIX_CFLAGS_COMPILE = "-D_POSIX_SOURCE";

  meta = with lib; {
    description = "A fork of old GNOME Screensaver for purposes of providing an authentication prompt on wake";
    longDescription = ''
      Budgie Screensaver is a fork of gnome-screensaver intended for use with
      Budgie Desktop and is similar in purpose to other screensavers such as
      MATE Screensaver. This repository and its respective software should
      largely be considered as being in "maintenance mode", only updating to
      resolve FTBFS issues or reflect changes in the GNOME Stack.
    '';
    homepage = "https://blog.buddiesofbudgie.org/";
    downloadPage = "https://github.com/BuddiesOfBudgie/budgie-screensaver/releases";
    mainProgram = "budgie-screensaver";
    platforms = platforms.linux;
    license = licenses.gpl2Only;
  };
}
