{ lib
, wireshark
, symlinkJoin
, makeWrapper
, onlyBin
, extCapPackages ? []

# Whether to include the extcap binaries provided by this repository
, includeExtCaps ? true
, ieee-802-15-4-sniffer ? null
, ice9-bluetooth-sniffer ? null
 }:

let
  extCapDir = symlinkJoin {
    name = "wireshark-extcap-dir";
    paths = lib.optionals includeExtCaps [ ieee-802-15-4-sniffer ice9-bluetooth-sniffer ] ++ extCapPackages;
    postBuild = ''
      # Link the builtin extcap programs because wireshark doesn't look in its own lib directory 
      # if the env var is set
      cp -vs ${wireshark}/lib/wireshark/extcap/* $out/bin

      # Some programs might've been wrapped and have a hidden `.orig.wrapped` file that we don't want
      # wireshark calling into
      rm -f $out/bin/.[!.]*
    '';
  };
in

symlinkJoin {
  name = "wireshark-wrapped";
  paths = [ wireshark ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
  for file in $out/bin/*; do
    wrapProgram $file --prefix WIRESHARK_EXTCAP_DIR : ${onlyBin extCapDir}/bin
  done
  '';
  meta = wireshark.meta;
}