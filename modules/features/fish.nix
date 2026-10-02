{ ... }: {
  flake.nixosModules.fish = { pkgs, ... }: {
    programs.fish.enable = true;
    users.users.vepelozi.shell = pkgs.fish;
  };

  flake = {
    modules.homeManager.fish = {
      programs.fish.enable = true;
    };
  };
}
