{
  lib,
  fetchFromGitHub,
  buildHomeAssistantComponent,
  python3,
}:

let
  pname = "connectlife-ha";
  version = "0.16.0";
  owner = "oyvindwe";
  domain = "connectlife";

  src = fetchFromGitHub {
    owner = "oyvindwe";
    repo = "connectlife-ha";
    rev = "v${version}";
    hash = "sha256-MOftMFJR5zDt8cC7CQTKn9sEpeyGC/zDHxPJxk8ctY0=";
    fetchSubmodules = true;
  };

  connectlife = python3.pkgs.callPackage ./connectlife.nix {};
in

buildHomeAssistantComponent rec {
  inherit pname version owner domain src;

  postInstall = ''
    cp -r connectlife $out/custom_components/${domain}/
  '';

  dontCheckManifest = true;
  dontBuild = true;

  dependencies = [
    connectlife
  ];

  meta = with lib; {
    description = "ConnectLife integration for Home Assistant";
    homepage = "https://github.com/oyvindwe/connectlife-ha";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ mrene ];
    platforms = platforms.all;
  };
}
