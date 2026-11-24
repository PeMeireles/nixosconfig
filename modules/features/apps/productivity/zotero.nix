{ inputs, ... }: {
  flake.nixosModules.zotero = { pkgs, ... }:
    let
      pkgsUnstable = import inputs.nixpkgs-unstable {
        inherit (pkgs.stdenv.hostPlatform) system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "firefox-esr-140-bin-unwrapped-140.17.0esr"
          ];
        };
      };
    in {
      nixpkgs.overlays = [
        (final: prev: {
          zotero = pkgsUnstable.zotero;
        })
      ];

      environment.systemPackages = [ pkgs.zotero ];
    };
}
