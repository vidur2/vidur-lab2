{
    description = "part 1 flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    };
    outputs = { self, nixpkgs }:
    let
    hellolib_overlay = final: prev: rec {
        hellolib = final.callPackage ./default.nix { };
    };
    my_overlays = [ hellolib_overlay ];


    pkgs = import nixpkgs {
        system = "aarch64-darwin";
        overlays = [ hellolib_overlay ];
    };
    in
    {
        packages.aarch64-darwin.default = pkgs.hellolib;
        overlays.default = nixpkgs.lib.composeManyExtensions my_overlays;
    };
}