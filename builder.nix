{
  lib,
  stdenvNoCC,
  lutgen,
  writers,

  version ? "unstable",
  variant ? null,
}:
let
  pname = if (variant == null) then "wallpapers" else "wallpapers-${variant}";

  lutApply = writers.writePython3Bin "lut-apply" { } ./scripts/lutgen.py;
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = lib.cleanSource ./wallpapers;

  nativeBuildInputs = [ lutgen ];

  installPhase = ''
    runHook preInstall

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
