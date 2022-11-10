{
  lib,
  stdenv,
  fetchurl,
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

  src = fetchurl {
    url = "https://github.com/EbonJaeger/${pname}/archive/refs/tags/v${version}-1.tar.gz";
    sha256 = "1qr5cafi748avhqc3p8zczvhyi1g571i443kz6244jnpp2h4m7hj";
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
