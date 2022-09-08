{
  lib,
  stdenv,
  glib,
  xorg,
  wrapGAppsHook,
  budgie-desktop,
  applets ? [],
}:
stdenv.mkDerivation {
  pname = "${budgie-desktop.pname}-with-applets";
  inherit (budgie-desktop) version;

  src = null;

  paths =
    [
      budgie-desktop
    ]
    ++ applets;

  passAsFile = ["paths"];

  nativeBuildInputs = [
    glib
    wrapGAppsHook
  ];

  buildInputs = lib.forEach applets (applet: applet.buildInputs) ++ applets;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  preferLocalBuild = true;
  allowSubstitutes = false;

  installPhase = ''
    mkdir -p $out
    for i in $(cat $pathsPath); do
      ${xorg.lndir}/bin/lndir -silent $i $out
    done
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --set BUDGIE_PLUGIN_PATH "$out/lib/budgie-desktop/plugins"
      --set BUDGIE_PLUGIN_DATA_PATH "$out/share/budgie-desktop/plugins"
    )
  '';

  inherit (budgie-desktop) passthru meta;
}
