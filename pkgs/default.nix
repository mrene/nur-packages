{ callPackage, gnuradio }:
let
  localLib = callPackage ../lib {};
in

(callPackage ./default {}) 

