{
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  curl,
  budgie-desktop,
  gnome-desktop,
  gtk3,
  json-glib,
  libpeas,
  libsoup,
  meson,
  ninja,
  pkg-config,
  vala,
  ...
}:
stdenv.mkDerivation rec {
  pname = "budgie-screenshot-applet";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "cybre";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-sCTNZ0I2Tc7vbGveQg1C5Uxo+sZVv9l/YJ6aY7xiHjQ=";
  };

  patches = [
    (fetchpatch {
      # Fixes compilation errors with Vala 0.44
      url = "https://github.com/cybre/budgie-screenshot-applet/commit/0e0c582adedc4105bb6677aa932e3ecc6ca35fc5.patch";
      sha256 = "sha256-3mV9NtBS7IQBzm2vUv6RwripnwhWyyeDoS4EiuJAMCg=";
    })
    (fetchpatch {
      # Fix GTK+3.24 compilation issues
      url = "https://github.com/cybre/budgie-screenshot-applet/commit/1886d97193a279c80c24d84c21cb10cec53b31a3.patch";
      sha256 = "sha256-3696KfAjiUH5TTrKsKzIzapJbDqVnx8MANDyOpLqHd0=";
    })
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
  ];

  buildInputs = [
    curl
    budgie-desktop
    gnome-desktop
    gtk3
    json-glib
    libpeas
    libsoup
  ];
}
