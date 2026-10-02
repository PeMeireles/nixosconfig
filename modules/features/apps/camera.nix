{ ... }: {
  flake.nixosModules.camera = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.kdePackages.kamoso
      pkgs.v4l-utils
    ];
  };
}
