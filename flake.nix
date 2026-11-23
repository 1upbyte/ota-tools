{
  description = "Nix packages for afsr and custota-tool";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      forEachSystem = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      packages = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          afsr = pkgs.callPackage ./pkgs/by-name/af/afsr/package.nix { };
          custota-tool = pkgs.callPackage ./pkgs/by-name/cu/custota-tool/package.nix { };
        }
      );
    };
}
