{ ... }: {
  flake.nixosModules.thunderbird = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.thunderbird ];
  };
}
