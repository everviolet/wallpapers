{
  description = "evergarden wallpapers";

  inputs.nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      outputSystems = lib.systems.flakeExposed;
      devSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = systems: fn: lib.genAttrs systems (system: fn nixpkgs.legacyPackages.${system});
    in
    {
      overlays.default = _: prev: import ./default.nix { pkgs = prev; };

      packages = forAllSystems outputSystems (
        pkgs:
        (import ./default.nix { inherit pkgs; })
        // {
          default = self.packages.${pkgs.stdenv.hostPlatform.system}.full;
        }
      );

      formatter = forAllSystems devSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
