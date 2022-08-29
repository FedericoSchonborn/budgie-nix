{ stdenv
, fetchurl
, meson
, ninja
, pkg-config
, vala
, intltool
, glib
, gtk3
, desktop-file-utils
}:

stdenv.mkDerivation rec{
  pname = "budgie-desktop-view";
  version = "1.2";

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "8399fae4326e5a21dda889bd89cb16ed8201f2854dc5cbc12394b90420d4cf2e";
  };

  patches = [
    ./0001-Disable-install-script-for-now.patch
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    intltool
    desktop-file-utils
  ];

  buildInputs = [
    glib
    gtk3
  ];
}
