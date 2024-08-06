{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "lovelace-slider-entity-row";
  version = "17.4.1";

  src = fetchFromGitHub {
    owner = "thomasloven";
    repo = "lovelace-slider-entity-row";
    rev = version;
    hash = "sha256-/unrsfM2s9vZUIQOoMEOr1n01KBgidpGRZ+NDjNNweY=";
  };
  npmDepsHash = "sha256-9z4YzLNxNh7I4yFxuPT3/erZO4itAiqyxL1a0pUTFRs=";

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp ./slider-entity-row.js $out/

    runHook postInstall
  '';


  passthru = {
    entrypoint = "slider-entity-row.js";
  };

  makeCacheWritable = true;

  meta = with lib; {
    description = "Add sliders to entity cards";
    homepage = "https://github.com/thomasloven/lovelace-slider-entity-row";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "lovelace-slider-entity-row";
    platforms = platforms.all;
  };
}
