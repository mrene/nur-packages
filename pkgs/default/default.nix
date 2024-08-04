{ callPackage, lib, newScope }:

let
  scope = lib.makeScope newScope (self: packages);
  packages = lib.filesystem.packagesFromDirectoryRecursive{
    inherit (scope) callPackage;
    directory = ./.;
  };
in packages