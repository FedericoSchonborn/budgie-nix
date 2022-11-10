{
  lib,
  stdenv,
  fetchurl,
  accountsservice,
  clutter,
  clutter-gtk,
  colord,
  colord-gtk,
  gcr,
  gettext,
  glib,
  gnome,
  gnome-desktop,
  gnome-online-accounts,
  gsound,
  gtk3,
  ibus,
  krb5,
  libepoxy,
  libgtop,
  libgudev,
  libhandy,
  libnma,
  libpulseaudio,
  libpwquality,
  libsecret,
  libwacom,
  libxml2,
  meson,
  modemmanager,
  networkmanager,
  ninja,
  pkg-config,
  polkit,
  samba,
  udisks,
  upower,
  wrapGAppsHook,
}:
stdenv.mkDerivation rec {
  pname = "budgie-control-center";
  version = "1.1.1";

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-${version}.tar.xz";
    sha256 = "Cg8nzuPloz8X5rNK1pi0pU/o73wdIVoKqaB0MXIqyWM=";
  };

  nativeBuildInputs = [
    gettext
    glib
    meson
    ninja
    pkg-config
    polkit # For Polkit ITS
    wrapGAppsHook
  ];

  buildInputs = [
    accountsservice
    clutter
    clutter-gtk
    colord
    colord-gtk
    gcr
    gnome-desktop
    gnome-online-accounts
    gnome.cheese
    gnome.gnome-bluetooth_1_0
    gnome.gnome-settings-daemon
    gsound
    gtk3
    ibus
    krb5
    libepoxy
    libgtop
    libgudev
    libhandy
    libnma
    libpulseaudio
    libpwquality
    libsecret
    libwacom
    libxml2
    modemmanager
    networkmanager
    samba
    udisks
    upower
  ];

  meta = with lib; {
    description = "A fork of GNOME Control Center for the Budgie 10 Series";
    longDescription = ''
      Budgie Control Center is a fork of GNOME Settings / GNOME Control Center
      with the intent of providing a simplified list of settings that are
      applicable to the Budgie 10 series, along with any small quality-of-life
      settings.
    '';
    homepage = "https://blog.buddiesofbudgie.org/";
    downloadPage = "https://github.com/BuddiesOfBudgie/budgie-control-center/releases";
    mainProgram = "budgie-control-center";
    platforms = platforms.linux;
    license = licenses.gpl2Plus;
  };
}
