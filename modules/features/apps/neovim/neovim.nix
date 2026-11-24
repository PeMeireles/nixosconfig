{...}: {
  flake.modules.homeManager.neovim = {pkgs, ...}: let
    shared = import ../../../../lib/neovim.nix {inherit pkgs;};
  in {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      initLua = ''
        require("init")
      '';

      extraPackages = shared.tools;
      plugins = shared.plugins;
    };

    xdg.configFile."nvim/lua".source = ./lua;
  };
}
