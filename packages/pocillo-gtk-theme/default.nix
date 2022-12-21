{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  nodePackages,
  ...
}:
stdenv.mkDerivation rec {
  pname = "pocillo-gtk-theme";
  version = "0.10";

  src = fetchFromGitHub {
    owner = "UbuntuBudgie";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-cYJmx3TtEe2L+qz6IVDQjfGhaJlE89J7O9aMjzLdSXs=";
  };

  patches = [
    ./Remove-all-sass-wackery.patch
  ];

  nativeBuildInputs = [
    meson
    ninja
    nodePackages.sass
  ];
}
