{inputs, ...}: {
  perSystem = {lib, pkgs, system, ...}: let
    supportedT3Code = system == "x86_64-linux";
    packagePkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    t3code = packagePkgs.appimageTools.wrapType2 {
      pname = "t3code";
      version = "0.1.1";
      src = packagePkgs.fetchurl {
        url = "https://github.com/pingdotgg/t3code/releases/download/v0.1.1/T3-Code-0.1.1-x86_64.AppImage";
        hash = "sha256-+KtS/hDvPLhyoIPQOP0SDdHsW0mP71aNBLKLenLGDDc=";
      };
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
    formatter = pkgs.alejandra;

    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        lua-language-server
        marksman
        nixd
        stylua
      ] ++ lib.optionals supportedT3Code [t3code];
    };

    packages.nvim = nvim;
    apps.nvim = {
      type = "app";
      program = "${nvimApp}/bin/nvim";
      meta.description = "Portable Neovim configuration";
    };
  } // lib.optionalAttrs supportedT3Code {
    packages.t3code = t3code;
    apps.t3code = {
      type = "app";
      program = "${t3code}/bin/t3code";
      meta.description = "T3 Code desktop app";
    };
  };
}
