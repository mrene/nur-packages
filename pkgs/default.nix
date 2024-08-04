{ callPackage, gnuradio }:
let
  localLib = callPackage ../lib {};
in

(callPackage ./default {}) //
{
  gnuradioPackages = localLib.scopeFromDirectoryRecursive {
    directory = ./gnuradio;
    extra = { inherit gnuradio; };
  };
}