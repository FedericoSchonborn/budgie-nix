{overlays, ...}: {
  imports = [
    ./programs/budgie-desktop-view.nix
    ./services/x11/desktop-managers/budgie.nix
  ];
}
