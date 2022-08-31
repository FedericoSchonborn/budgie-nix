{ stdenv
, fetchurl
, fetchpatch
, meson
, ninja
, pkg-config
, vala
, intltool
, glib
, gtk3
, desktop-file-utils
, wrapGAppsHook
}:

let
  pname = "budgie-desktop-view";
  version = "1.2";
in

stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "8399fae4326e5a21dda889bd89cb16ed8201f2854dc5cbc12394b90420d4cf2e";
  };

  patches = [
    (fetchpatch {
      # Remove unused gtk-update-icon-cache
      url = "https://github.com/BuddiesOfBudgie/${pname}/commit/b76a518b97beb65d1096344f6ba9e9a3f647d9a1.patch";
      sha256 = "Cgk8Q8QNkauVs80kP6vZuXbtdXBXk1px+83eBlkpwl8=";
    })
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    intltool
    desktop-file-utils
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    gtk3
  ];

  preInstall = ''
    substituteInPlace ../scripts/mesonPostInstall.sh --replace "update-desktop-database -q" "update-desktop-database $out/share/applications"
  '';
}
