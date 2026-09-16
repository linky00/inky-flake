{
  description = "inky, the editor for ink";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        inky = pkgs.callPackage ./package.nix { };
        default = self.packages.${system}.inky;
      };

      overlays.default = final: prev: {
        inky = final.callPackage ./package.nix { };
      };

      formatter.${system} = pkgs.nixfmt-tree;

      checks.${system}.inky = self.packages.${system}.inky;
    };
}
