system := `nix eval nixpkgs#system`
packages := "budgie-app-launcher budgie-applications-menu budgie-backgrounds budgie-brightness-controller budgie-control-center budgie-desktop budgie-desktop-view budgie-fuzzyclock budgie-kangaroo budgie-keyboard-autoswitch budgie-network-manager budgie-quicknote budgie-rotation-lock budgie-screensaver budgie-screenshot-applet budgie-trash budgie-trash-applet budgie-workspace-stopwatch pocillo-gtk-theme"

@_default:
    just --list
    echo "System: {{ system }}"

# Build all packages.
@build-all:
    just build {{ packages }}

# Build one or more packages.
build +PACKAGES:
    for package in {{ PACKAGES }}; do \
        nix build --print-build-logs ".#${package}"; \
    done

# Run the demo virtual machine.
@demo-vm:
    just _vm demo

# Run the installer ISO virtual machine.
@install-iso-vm:
    just _vm install-iso

_vm NAME:
    nix build --print-build-logs ".#nixosConfigurations.{{ NAME }}.config.system.build.vm"
    rm -f *.qcow2
    ./result/bin/run-nixos-vm
