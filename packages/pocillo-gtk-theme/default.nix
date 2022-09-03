{
  lib,
  stdenv,
  fetchurl,
  meson,
  ninja,
  sass,
  ...
}: let
  pname = "pocillo-gtk-theme";
  version = "0.9";
in
  stdenv.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/UbuntuBudgie/${pname}/archive/refs/tags/v${version}.tar.gz";
      sha256 = "1l37im5ww9jf5ag12kmpjdi7nn1psff86s3k73bb81r1s6vpzfvv";
    };

    patches = [
      ./0001-Remove-Dart-Sass-references-and-fix-compiler-flags.patch
    ];

    nativeBuildInputs = [
      meson
      ninja
      sass
    ];

    meta = with lib; {
      description = "A Material Design theme for the Budgie Desktop";
      longDescription = ''
        GTK+ 3.22 & GTK+ 4 based theme for the Budgie Desktop that has Material
        Design elements and styled using the Arc colour palette.
      '';
      homepage = "https://ubuntubudgie.org/";
      downloadPage = "https://github.com/UbuntuBudgie/pocillo-gtk-theme/releases";
      license = licenses.gpl2Plus;
    };
  }
