{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    packagePkgs = import inputs.nixpkgs {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
    plugins = with packagePkgs.vimPlugins; [
      lz-n
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      vim-sleuth
      blink-cmp
      snacks-nvim
      oil-nvim
      fzf-lua
      conform-nvim
      project-nvim
      barbar-nvim
      nightfox-nvim
      mini-icons
      mini-statusline
      which-key-nvim
      noice-nvim
      nui-nvim
      nvim-notify
      showkeys
    ];
    nvim = packagePkgs.neovim.override {
      configure = {
        customRC = ''
          set runtimepath^=${./features/apps/neovim}
          lua require("init")
        '';
        packages.nvim.start = plugins;
      };
    };
  in {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        lua-language-server
        marksman
        nixd
        stylua
      ];
    };

    packages.nvim = nvim;
    apps.nvim = {
      type = "app";
      program = "${nvim}/bin/nvim";
      meta.description = "Portable Neovim configuration";
    };
  };
}
