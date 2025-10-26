{ gnuradio, boost181, ... }@args:

# Recent updates upgraded boost to a version which deprecated a lot of things causing a lot of breakage
# Since boost versions have to match, override it to the last known working version
gnuradio.override ({
  unwrapped = gnuradio.unwrapped.overrideAttrs (old: {
    boost = boost181;
    patches = (old.patches or []) ++ [
      ./fix-boost-format-formatter.patch
    ];
  });
} // (removeAttrs args ["boost181" "gnuradio"] ))  