{ ... }: {
  flake.modules.nixos.camera = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.kdePackages.kamoso
      pkgs.v4l-utils
    ];
  };
}
