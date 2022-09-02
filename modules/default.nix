{budgie-overlay, ...}: {
  imports = [
    ./programs/budgie-desktop-view.nix
    ./services/x11/desktop-managers/budgie.nix
  ];
  nixpkgs.overlays = [budgie-overlay];
}
