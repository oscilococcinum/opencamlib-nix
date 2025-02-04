{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map (system: 
      {
        name = system;
        value = with import nixpkgs { inherit system; config.allowUnfree = true;}; rec {
          
          opencamlib = pkgs.callPackage (import ./opencamlib) { };

          opencamlib-pypi = pkgs.callPackage (import ./opencamlib/pypi.nix) { };

          default = opencamlib;
        };
      }
    )[ "x86_64-linux" ]);
  };
}
