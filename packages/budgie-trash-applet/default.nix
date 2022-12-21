{
  lib,
  stdenv,
  fetchFromGitHub,
  budgie-desktop,
  gtk3,
  libnotify,
  libpeas,
  meson,
  ninja,
  pkg-config,
  sassc,
}:
stdenv.mkDerivation rec {
  pname = "budgie-trash-applet";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "EbonJaeger";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-Wjc/NYnnvjYzeIbiBW1qMlSMSBmVSeLochHaWOD2rL8=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    sassc
  ];

  buildInputs = [
    budgie-desktop
    gtk3
    libnotify
    libpeas
  ];

  meta = with lib; {
    description = "The default background set for the Budgie Desktop";
    longDescription = ''
      Budgie Backgrounds is the default set of background images for the Budgie Desktop.
    '';
    homepage = "https://blog.buddiesofbudgie.org/";
    downloadPage = "https://github.com/BuddiesOfBudgie/budgie-backgrounds/releases";
    platforms = platforms.linux;
    license = licenses.asl20;
  };
}
