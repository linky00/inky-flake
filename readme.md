# inky

nix flake for [inky](https://github.com/inkle/inky), the editor for ink.

## use

add the input

    inputs.inky.url = "github:garmir/inky";

install the package

    environment.systemPackages = [ inputs.inky.packages.${pkgs.system}.default ];

or use the overlay

    nixpkgs.overlays = [ inputs.inky.overlays.default ];
    environment.systemPackages = [ pkgs.inky ];

## run without installing

    nix run github:garmir/inky

x86_64-linux only.
