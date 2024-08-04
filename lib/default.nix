{ lib, newScope }:

{
  scopeFromDirectoryRecursive = { directory, extra ? {} }: let
    scope = lib.makeScope newScope (self: extra // packages);
    packages = lib.filesystem.packagesFromDirectoryRecursive{
      inherit (scope) callPackage;
      inherit directory;
    };
    in packages;
}
