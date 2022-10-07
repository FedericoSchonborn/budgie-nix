{
  system,
  pkgs,
  checks,
  ...
}:
pkgs.mkShell {
  inherit (checks.${system}.pre-commit-hook) shellHook;
  buildInputs = with pkgs; [
    jq
    (pkgs.writeShellScriptBin "buildAll" "nix flake show --json | jq  '.packages.\"${system}\"|keys[]' | xargs -I {} nix build .#{} -o result-{}")
    (pkgs.writeShellScriptBin "buildVm" "nixos-rebuild build-vm --flake .#${system}")
    (pkgs.writeShellScriptBin "runVm" "buildVm && ./result/bin/run-nixos-vm")
    (pkgs.writeShellScriptBin "runFreshVm" "rm -v *.qcow2 && runVm")
  ];
}
