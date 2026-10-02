{ ... }: {
  flake = {
    modules.homeManager.terminal = {
      programs.kitty = {
        enable = true;
        extraConfig = ''
          include ~/.config/kitty/dank-tabs.conf
          include ~/.config/kitty/dank-theme.conf
        '';
      };
    };
  };
}
