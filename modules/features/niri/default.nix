{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };

  flake = {
    modules.homeManager.niri = { pkgs, ... }: {
      imports = [
        inputs.niri-nix.homeModules.default
        self.modules.homeManager.niri-settings
        self.modules.homeManager.niri-keybinds
      ];

      wayland.windowManager.niri = {
        enable = true;
        package = pkgs.niri;
      };
    };
  };
}
