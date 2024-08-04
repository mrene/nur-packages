{ lib, newScope, callPackage, gnuradio, gnuradioPackages, ... }@args:

(gnuradio.override {
  # extraPackages = builtins.attrValues gnuradioPackages;
  extraPythonPackages = with gnuradio.python.pkgs; [ soapysdr ];
} // args) // {
  pkgs = gnuradio.pkgs.overrideScope (final: prev: gnuradioPackages);
}