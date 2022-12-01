{
  lib,
  stdenv,
  fetchFromGitHub,
  accountsservice,
  alsa-lib,
  budgie-screensaver,
  docbook-xsl-nons,
  glib,
  gnome,
  gnome-desktop,
  gnome-menus,
  graphene,
  gtk-doc,
  gtk3,
  ibus,
  intltool,
  libGL,
  libnotify,
  libpeas,
  libpulseaudio,
  libuuid,
  libwnck,
  mesa,
  meson,
  ninja,
  pkg-config,
  polkit,
  sassc,
  upower,
  vala,
  wrapGAppsHook,
}:
stdenv.mkDerivation rec {
  pname = "budgie-desktop";
  version = "10.6.4";

  src = fetchFromGitHub {
    owner = "BuddiesOfBudgie";
    repo = "${pname}";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "JfCKUNNdbyXvexrWWip8EpWVaW+PpwQ0vkrpr6M41ds=";
  };

  patches = [
    ./0001-Add-environment-variable-overrides-for-plugin-paths.patch
  ];

  nativeBuildInputs = [
    docbook-xsl-nons
    gtk-doc
    intltool
    meson
    ninja
    pkg-config
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    accountsservice
    alsa-lib
    budgie-screensaver
    glib
    gnome-desktop
    gnome-menus
    gnome.gnome-bluetooth_1_0
    gnome.gnome-settings-daemon
    gnome.mutter
    graphene
    gtk3
    ibus
    libGL
    libnotify
    libpeas
    libpulseaudio
    libuuid
    libwnck
    mesa
    polkit
    sassc
    upower
  ];

  passthru.providedSessions = [
    "budgie-desktop"
  ];

  # NOTE: No mainProgram because Budgie has multiple components (panel, runner, polkit-dialog).
  meta = with lib; {
    description = "A familiar, modern desktop environment";
    longDescription = ''
      The Budgie Desktop is a feature-rich, modern desktop designed to keep out the way of the user.
    '';
    homepage = "https://blog.buddiesofbudgie.org/";
    downloadPage = "https://github.com/BuddiesOfBudgie/budgie-desktop/releases";
    platforms = platforms.linux;
    license = with licenses; [
      # LICENSE
      gpl2Plus
      # LICENSE.LGPL2.1
      lgpl21Plus
      # data/backgrounds (see README.md)
      cc-by-sa-30
    ];
  };
}
