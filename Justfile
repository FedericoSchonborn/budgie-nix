system := `nix eval nixpkgs#system`
packages := "budgie-app-launcher budgie-applications-menu budgie-backgrounds budgie-brightness-controller budgie-control-center budgie-desktop budgie-desktop-view budgie-desktop-with-applets budgie-fuzzyclock budgie-kangaroo budgie-keyboard-autoswitch budgie-network-manager budgie-quicknote budgie-rotation-lock budgie-screensaver budgie-trash budgie-trash-applet budgie-workspace-stopwatch pocillo-gtk-theme"

@_default:
    just --list

# Build all packages.
@build-all:
    just build {{ packages }}

# Build one or more packages.
@build +PACKAGES:
    for package in {{ PACKAGES }}; do \
        nix build --print-build-logs ".#${package}"; \
    done

# Run the demo virtual machine.
@demo-vm:
    nix build --print-build-logs ".#nixosConfigurations.demo.config.system.build.vm"
    rm *.qcow2
    ./result/bin/run-nixos-vm

# Run the installer ISO virtual machine.
@install-iso-vm:
    nix build --print-build-logs ".#nixosConfigurations.install-iso.config.system.build.vm"
    rm *.qcow2
    ./result/bin/run-nixos-vm
