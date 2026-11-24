{ inputs, ... }: {
  flake.modules.nixos.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    xdg.portal.enable = true;

    services.flatpak = {
      enable = true;
      update.onActivation = true;
    };
  };
}
