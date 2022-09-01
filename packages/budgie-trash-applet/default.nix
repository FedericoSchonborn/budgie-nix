{
  stdenv,
  fetchurl,
  meson,
  pkg-config,
  sassc,
  ninja,
  gtk3,
  libpeas,
  libnotify,
  budgie-desktop,
}: let
  pname = "budgie-trash-applet";
  version = "2.1.1";
in
  stdenv.mkDerivation {
    inherit pname version;

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
      gtk3
      libpeas
      libnotify
      budgie-desktop
    ];
  }
