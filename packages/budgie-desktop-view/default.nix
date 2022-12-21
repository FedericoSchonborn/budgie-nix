{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  desktop-file-utils,
  glib,
  gtk3,
  intltool,
  meson,
  ninja,
  pkg-config,
  vala,
  wrapGAppsHook,
}:
stdenv.mkDerivation rec {
  pname = "budgie-desktop-view";
  version = "1.2";

  src = fetchFromGitHub {
    owner = "BuddiesOfBudgie";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-g7UziBmeqKlNzEBgySPgr+3h17Us67xmOAzOhIHwJl0=";
  };

  patches = [
    (fetchpatch {
      # Remove unused gtk-update-icon-cache
      url = "https://github.com/BuddiesOfBudgie/${pname}/commit/b76a518b97beb65d1096344f6ba9e9a3f647d9a1.patch";
      sha256 = "sha256-Cgk8Q8QNkauVs80kP6vZuXbtdXBXk1px+83eBlkpwl8=";
    })
  ];

  nativeBuildInputs = [
    desktop-file-utils
    intltool
    meson
    ninja
    pkg-config
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    gtk3
  ];

  preInstall = ''
    substituteInPlace ../scripts/mesonPostInstall.sh --replace "update-desktop-database -q" "update-desktop-database $out/share/applications"
  '';

  meta = with lib; {
    description = "Official Budgie desktop icons application/implementation";
    longDescription = ''
      Budgie Desktop View is the official Budgie desktop icons application/implementation.
    '';
    homepage = "https://blog.buddiesofbudgie.org/";
    downloadPage = "https://github.com/BuddiesOfBudgie/budgie-desktop-view/releases";
    mainProgram = "org.buddiesofbudgie.budgie-desktop-view";
    platforms = platforms.linux;
    license = licenses.asl20;
  };
}
