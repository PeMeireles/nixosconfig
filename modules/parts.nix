{ lib, self, ... }:
{
  options.flake.modules = lib.mkOption {
    type = lib.types.attrsOf (lib.types.attrsOf lib.types.raw);
    default = { };
    description = "Dendritic NixOS and Home Manager modules.";
  };

  config = {
    # Preserve the conventional public flake output for existing consumers.
    flake.nixosModules = self.modules.nixos;
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
