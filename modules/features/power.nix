{ ... }: {
  flake.nixosModules.power = {
    services.upower.enable = true;
    services.acpid.enable = true;
  };
}
