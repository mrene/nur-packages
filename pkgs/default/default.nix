{ callPackage, gnuradio }:
let
  localLib = callPackage ../../lib {};
in

localLib.scopeFromDirectoryRecursive {
  directory = ./.;
  extra = {
    localGnuradioPackages = localLib.scopeFromDirectoryRecursive {
      directory = ./gnuradio;
      extra = { inherit gnuradio; };
    };
  };
}