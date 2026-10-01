{ inputs, ... }: {
  flake.nixosModules.dms = { pkgs, ... }: {
    imports = [ inputs.dms.nixosModules.dank-material-shell ];

    programs.dank-material-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.system}.dms-shell;
      systemd.enable = true;
    };

    # Seed DMS settings only when the user does not have them yet.
    system.activationScripts.dmsSettings.text = ''
      dms_config_dir=/home/vepelozi/.config/DankMaterialShell
      dms_settings=$dms_config_dir/settings.json
      install -d -o vepelozi -g users "$dms_config_dir"
      if [ ! -e "$dms_settings" ]; then
        install -o vepelozi -g users -m 0644 \
          ${../../.config/DankMaterialShell/settings.json} "$dms_settings"
      fi
    '';
  };

  perSystem = { inputs', ... }: {
    packages.dms = inputs'.dms.packages.dms-shell;
  };
}
