{ lib
, stdenv
, fetchFromGitHub
, cmake
, soapysdr-with-plugins
}:

stdenv.mkDerivation rec {
  pname = "rx-tools";
  version = "unstable-2019-03-31";

  src = fetchFromGitHub {
    owner = "rxseger";
    repo = "rx_tools";
    rev = "master";
    hash = "sha256-WacMVC0rohyHnZexGj2Zby9aD4AYwJvljACbzQDAKGM=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    soapysdr-with-plugins
  ];

  meta = with lib; {
    description = "Rx_fm, rx_power, and rx_sdr tools for receiving data from SDRs, based on rtl_fm, rtl_power, and rtl_sdr from librtlsdr, but using the SoapySDR vendor-neutral SDR support library instead, intended to support a wider range of devices than RTL-SDR";
    homepage = "https://github.com/rxseger/rx_tools";
    license = licenses.gpl2Only;
  };
}
