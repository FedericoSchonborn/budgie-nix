{
  lib,
  stdenv,
  fetchFromGitHub,
  imagemagick,
  jhead,
  meson,
  ninja,
}:
stdenv.mkDerivation rec {
  pname = "budgie-backgrounds";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "BuddiesOfBudgie";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "pDFd+WvWOPgDoSffmX9mzjDQbhePsJV1wGqmPDcnOlw=";
  };

  nativeBuildInputs = [
    imagemagick
    jhead
    meson
    ninja
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
