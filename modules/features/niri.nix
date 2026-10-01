{ ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    # Seed the editable user config only once.
    system.activationScripts.niriConfig.text = ''
      config_dir=/home/vepelozi/.config/niri
      config_file=$config_dir/config.kdl
      install -d -o vepelozi -g users "$config_dir"
      if [ ! -e "$config_file" ]; then
        install -o vepelozi -g users -m 0644 \
          ${../../.config/niri/config.kdl} "$config_file"
      fi
    '';

    system.activationScripts.niriDmsBinds.text = ''
      dms_dir=/home/vepelozi/.config/niri/dms
      dms_binds=$dms_dir/binds.kdl
      install -d -o vepelozi -g users "$dms_dir"
      if [ ! -e "$dms_binds" ]; then
        install -o vepelozi -g users -m 0644 \
          ${../../.config/niri/dms/binds.kdl} "$dms_binds"
      fi
    '';
  };
}
