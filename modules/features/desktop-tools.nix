{ ... }: {
  flake.nixosModules.desktopTools = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.kitty
      pkgs.opencode
    ];

  };

  flake.modules.homeManager.kitty = {
    programs.kitty = {
      enable = true;
      extraConfig = ''
        include ~/.config/kitty/dank-tabs.conf
        include ~/.config/kitty/dank-theme.conf
      '';
    };
  };
}
