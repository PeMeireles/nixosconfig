{ ... }: {
  flake.nixosModules.zotero = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.zotero ];
  };
}
