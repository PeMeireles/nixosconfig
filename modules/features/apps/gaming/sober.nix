{ self, ... }: {
  flake.modules.nixos.sober = {
    imports = [ self.modules.nixos.flatpak ];

    services.flatpak.packages = [ "org.vinegarhq.Sober" ];
  };
}
