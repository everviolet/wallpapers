{
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,
  version ? "unstable",
}:
let
  genVariant =
    variant:
    pkgs.callPackage ./builder.nix {
      inherit variant version;
    };

  variants = {
    # includes all variants and unthemed
    full = null;

    unthemed = "unthemed";
    winter = "winter";
    fall = "fall";
    spring = "spring";
    summer = "summer";
  };

  packages = lib.mapAttrs (_: genVariant) variants;
in
packages
