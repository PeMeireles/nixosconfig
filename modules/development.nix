{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    packagePkgs = import inputs.nixpkgs {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
    copilotLua = packagePkgs.vimPlugins.copilot-lua.overrideAttrs (_: {
      src = packagePkgs.fetchFromGitHub {
        owner = "zbirenbaum";
        repo = "copilot.lua";
        rev = "v2.0.4";
        hash = "sha256-05f76OeWBlFmlUh90tH4XMMKfNI1jnhuIJDqYPPQokA=";
      };
    });
    plugins = with packagePkgs.vimPlugins; [
      lz-n
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      vim-sleuth
      blink-cmp
      blink-compat
      blink-copilot
      copilotLua
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
    nvimApp = packagePkgs.writeShellApplication {
      name = "nvim";
      runtimeInputs = [packagePkgs.copilot-language-server];
      text = ''
        exec ${nvim}/bin/nvim "$@"
      '';
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
      program = "${nvimApp}/bin/nvim";
      meta.description = "Portable Neovim configuration";
    };
  };
}
