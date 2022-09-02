{
  system,
  pkgs,
  checks,
  ...
}: let
  buildAll = pkgs.writeShellScriptBin "buildAll" "nix flake show --json | jq  '.packages.\"${system}\"|keys[]' | xargs -I {} nix build .#{} -o result-{}";
  buildVm = pkgs.writeShellScriptBin "buildVm" "nixos-rebuild build-vm --flake .#${system}";
  runVm = pkgs.writeShellScriptBin "runVm" "buildVm && ./result/bin/run-nixos-vm";
  runFreshVm = pkgs.writeShellScriptBin "runFreshVm" "rm *.qcow2 && runVm";
in
  pkgs.mkShell {
    inherit (checks.${system}.pre-commit-hook) shellHook;
    buildInputs = with pkgs; [
      rnix-lsp
      nixpkgs-fmt
      jq
      buildAll
      buildVm
      runVm
      runFreshVm
    ];
  }
