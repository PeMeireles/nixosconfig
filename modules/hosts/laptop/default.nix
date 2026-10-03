{
  self,
  inputs,
  ...
}: {
  flake = {
    modules = {
      nixos.laptop = {
        imports = with self.nixosModules; [
          laptopConfiguration
          dms
          dankGreeter
          niri
          flatpak
          sober
          dolphin
          terminal
          fish
          camera
          discord
          thunderbird
        ];

        home-manager.backupFileExtension = "hm-backup";
      };

      homeManager.laptop-vepelozi = {
        imports = with self.modules.homeManager; [
          niri
          dms
          terminal
          fish
          cursor
          creative
          media
           default-apps
           dolphin
           neovim
         ];

        nixpkgs.config.allowUnfree = true;
        home.stateVersion = "26.05";
      };
    };

    nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.home-manager.nixosModules.home-manager
        self.modules.nixos.laptop
        {
          home-manager.users.vepelozi = self.modules.homeManager.laptop-vepelozi;
        }
      ];
    };
  };
}
