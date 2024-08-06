{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master"; # Change when #330477 is merged
  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "aarch64-linux"
        "armv6l-linux"
        "armv7l-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
      bySystem = forAllSystems (system: import ./default.nix {
        pkgs = import nixpkgs { inherit system; };
      });
      lib = nixpkgs.lib;
    in
    {
      packages = forAllSystems (system: 
          lib.filterAttrs (_: v: 
            (lib.isDerivation v) && (lib.meta.availableOn { inherit system; } v))
            bySystem.${system}.packages.default
      );
    };
}
