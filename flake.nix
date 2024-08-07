{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master"; # Change when #330477 is merged
  nixConfig = {
    extra-substituters = [ "https://nixcache.mathieurene.com/nur" ];
    extra-trusted-public-keys = [ "nixcache.mathieurene.com-1:/HeC3enYzhY920VJrGNSUdMOqXUh3Y/zLo3+f5IZjfM=" ];
  };
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
