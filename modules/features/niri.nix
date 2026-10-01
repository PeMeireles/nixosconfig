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
  };
}
