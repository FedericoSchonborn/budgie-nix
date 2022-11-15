system := "`uname -m`-linux"
packages := "budgie-app-launcher budgie-applications-menu budgie-backgrounds budgie-brightness-controller budgie-control-center budgie-desktop budgie-desktop-view budgie-desktop-with-applets budgie-fuzzyclock budgie-kangaroo budgie-keyboard-autoswitch budgie-network-manager budgie-quicknote budgie-rotation-lock budgie-screensaver budgie-trash budgie-trash-applet budgie-workspace-stopwatch"
release-branch := "nixos-22.05"

@_default:
    just --list

# Build all packages (unstable branch).
@build-all:
    just build {{ packages }}

# Build all packages (release branch).
@build-all-release:
    just build-release {{ packages }}

# Build one or more packages (unstable branch).
@build +PACKAGES:
    for package in {{ PACKAGES }}; do \
        nix build --print-build-logs ".#${package}"; \
    done

# Build one or more packages (release branch).
@build-release +PACKAGES:
    for package in {{ PACKAGES }}; do \
        nix build --print-build-logs ".#${package}" --override-input nixpkgs "github:NixOS/nixpkgs/{{ release-branch }}"; \
    done

# Run the virtual machine.
@run-vm: build-vm
    ./result/bin/run-nixos-vm

# Run the virtual machine in a clean state.
@run-clean-vm: build-vm && run-vm
    rm -v *.qcow2

# Build the virtual machine (unstable branch).
@build-vm:
    nix build --print-build-logs ".#nixosConfigurations.budgie.config.system.build.vm"

# Build the virtual machine (release branch).
@build-vm-release:
    nix build --print-build-logs ".#nixosConfigurations.budgie.config.system.build.vm" --override-input nixpkgs "github:NixOS/nixpkgs/{{ release-branch }}"
