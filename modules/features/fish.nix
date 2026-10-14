{ ... }: {
  flake.nixosModules.fish = { pkgs, ... }: {
    programs.fish.enable = true;
    users.users.vepelozi.shell = pkgs.fish;
  };

  flake = {
    modules.homeManager.fish = { pkgs, ... }: {
      programs.fish.enable = true;

      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableFishIntegration = true;
      };

      home.packages = [
        pkgs.lazygit
        pkgs.ouch
        pkgs.ripgrep
        pkgs.tealdeer
        pkgs.wl-clipboard
      ];
    };
  };
}
