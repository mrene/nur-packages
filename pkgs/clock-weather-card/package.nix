{ lib
, stdenv
, fetchFromGitHub
, cacert
, nodejs
, yarn-berry
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "clock-weather-card";
  version = "2.9.3";

  src = fetchFromGitHub {
    owner = "pkissling";
    repo = "clock-weather-card";
    rev = "v${finalAttrs.version}";
    hash = "sha256-CeOrJFdvl9O6TF9E2W34mR6VmLnTzhXGmrBmbtsBLxA=";
  };

  yarnOfflineCache = stdenv.mkDerivation {
    pname = "${finalAttrs.pname}-yarn-deps";
    inherit (finalAttrs) version src;

    nativeBuildInputs = [ yarn-berry ];

    dontInstall = true;

    env = {
      YARN_ENABLE_TELEMETRY = 0;
      NODE_EXTRA_CA_CERTS = "${cacert}/etc/ssl/certs/ca-bundle.crt";
    };

    configurePhase = ''
      runHook preConfigure

      export HOME="$NIX_BUILD_TOP"
      yarn config set enableGlobalCache false
      yarn config set cacheFolder $out

      runHook postConfigure
    '';

    buildPhase = ''
      runHook preBuild

      mkdir -p $out
      yarn install --immutable --mode skip-build

      runHook postBuild
    '';

    outputHash = "sha256-fi5qN1M31hlH9+M0LiP2aDuF7cRxHgaBG+L6aeUATHU=";
    outputHashMode = "recursive";
  };

  nativeBuildInputs = [
    nodejs
    yarn-berry
  ];

  configurePhase = ''
    runHook preConfigure

    export HOME="$NIX_BUILD_TOP"
    yarn config set enableGlobalCache false
    yarn config set cacheFolder $yarnOfflineCache

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    yarn install --immutable --immutable-cache
    yarn build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp dist/clock-weather-card.js $out/

    runHook postInstall
  '';

  meta = with lib; {
    description = "A Home Assistant Card indicating today's date/time, along with an iOS inspired weather forecast for the next days with animated icons";
    homepage = "https://github.com/pkissling/clock-weather-card";
    changelog = "https://github.com/pkissling/clock-weather-card/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ mrene ];
    platforms = platforms.linux;
  };
})
