{
  lib,
  stdenv,
  fetchurl,
  meson,
  ninja,
  imagemagick,
  jhead,
}:
stdenv.mkDerivation rec {
  pname = "budgie-backgrounds";
  version = "0.1";

  src = fetchurl {
    url = "https://github.com/BuddiesOfBudgie/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "0mf6sclq7gb3fkga5h03913z0j2nry8v4x85d0s4hc6aqc7jkjh6";
  };

  nativeBuildInputs = [
    meson
    ninja
    imagemagick
    jhead
  ];

  preConfigure = ''
    chmod +x ./scripts/optimizeImage.sh
    patchShebangs --host ./scripts/optimizeImage.sh
  '';

  meta = with lib; {
    description = "The default background set for the Budgie Desktop";
    longDescription = ''
      Budgie Backgrounds is the default set of background images for the Budgie Desktop.
    '';
    homepage = "https://blog.buddiesofbudgie.org/";
    downloadPage = "https://github.com/BuddiesOfBudgie/budgie-backgrounds/releases";
    platforms = platforms.linux;
    license = licenses.cc0;
  };
}
