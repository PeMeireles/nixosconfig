{ ... }: {
  flake.nixosModules.fish = { pkgs, ... }: {
    programs.fish.enable = true;
    users.users.vepelozi.shell = pkgs.fish;
  };

  flake.homeModules.fish = {
    programs.fish.enable = true;
  };
}
