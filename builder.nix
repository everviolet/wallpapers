{
  lib,
  stdenvNoCC,
  lutgen,
  writers,

  whiskers,

  version ? "unstable",
  variant ? null,
}:
let
  pname = if (variant == null) then "wallpapers" else "wallpapers-${variant}";

  lutApply = writers.writePython3Bin "lut-apply" { } ./scripts/lutgen.py;
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.union ./wallpapers ./palette.tera;
  };

  nativeBuildInputs = [
    lutgen
    whiskers
  ];

  installPhase = ''
    runHook preInstall

    whiskers palette.tera

    mkdir -p $out/share/wallpapers
    ${lib.getExe lutApply} $src $out/share/wallpapers ${lib.optionalString (variant != null) variant}

    runHook postInstall
  '';

  meta = {
    description = "evergarden wallpapers" + lib.optionalString (variant != null) " (${variant})";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ comfysage ];
  };
}
