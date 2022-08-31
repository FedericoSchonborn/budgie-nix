{ stdenv
, fetchFromGitHub
, meson
, ninja
, imagemagick
, jhead
}:

let
  pname = "budgie-backgrounds";
  version = "unstable-2022-08-30";
  rev = "f0944f81359e7eb78c54fd9329b11fc2e46af2df";
in

stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit rev;
    owner = "BuddiesOfBudgie";
    repo = pname;
    sha256 = "Z9YpcpBXNLVzsGzQ/EoM7E4YV5etSoJYbkhzz9Pbb1I=";
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
}
