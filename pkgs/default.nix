{ callPackage, gnuradio }:
let
  localLib = callPackage ../lib {};
in

localLib.scopeFromDirectoryRecursive {
  directory = ./.;
}