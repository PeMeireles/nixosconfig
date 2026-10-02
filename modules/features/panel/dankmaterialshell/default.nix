{ self, inputs, ... }: {
  flake.nixosModules.dms = { pkgs, ... }: {
    imports = [ inputs.dms.nixosModules.dank-material-shell ];

    programs.dank-material-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.system}.dms-shell;
      systemd.enable = true;
    };
  };

    flake = {
    modules.homeManager.dms = { pkgs, ... }: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        self.modules.homeManager.dms-niri
        self.modules.homeManager.dms-settings
      ];

      gtk.iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      home.packages = [ pkgs.papirus-icon-theme ];
      home.sessionVariables.GTK_ICON_THEME = "Papirus-Dark";

      programs.dank-material-shell.enable = true;
    };
  };
}
