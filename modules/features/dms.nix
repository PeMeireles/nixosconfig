{ inputs, ... }: {
  flake.nixosModules.dms = { pkgs, ... }: {
    imports = [ inputs.dms.nixosModules.dank-material-shell ];

    programs.dank-material-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.system}.dms-shell;
      systemd.enable = true;
    };

  };

  flake = {
    modules.homeManager.dms = { ... }: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
      ];
      programs.dank-material-shell = {
        enable = true;
      };
    };
  };
}
