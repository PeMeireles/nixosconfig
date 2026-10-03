{ ... }: {
  flake.nixosModules.fish = { pkgs, ... }: {
    programs.fish.enable = true;
    users.users.vepelozi.shell = pkgs.fish;
  };

  flake = {
    modules.homeManager.fish = { pkgs, ... }: {
      programs.fish.enable = true;

      home.packages = [
        pkgs.ouch
        pkgs.wl-clipboard
      ];
    };
  };
}
