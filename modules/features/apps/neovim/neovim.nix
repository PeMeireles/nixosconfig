{...}: {
  flake.modules.homeManager.neovim = {pkgs, ...}:
    let
      cmpSql = pkgs.vimUtils.buildVimPlugin {
        pname = "cmp-sql";
        version = "unstable-2025-01-01";
        doCheck = false;
        src = pkgs.fetchFromGitHub {
          owner = "ray-x";
          repo = "cmp-sql";
          rev = "master";
          hash = "sha256-ZQRomBw7Qr7ILC0B9KJx63OXi2UoG6aFvh06zLDZlR8=";
        };
      };
      copilotLua = pkgs.vimPlugins.copilot-lua.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "zbirenbaum";
          repo = "copilot.lua";
          rev = "v2.0.4";
          hash = "sha256-05f76OeWBlFmlUh90tH4XMMKfNI1jnhuIJDqYPPQokA=";
        };
      });
    in {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      initLua = ''
        require("init")
      '';

      extraPackages = with pkgs; [
        fzf
        tree-sitter
      ];

      plugins = with pkgs.vimPlugins; [
        lz-n
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
          vim-sleuth
          nvim-cmp
          blink-cmp
          blink-compat
          blink-emoji-nvim
          blink-copilot
          copilotLua
          friendly-snippets
          cmpSql
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
    };

    xdg.configFile."nvim/lua".source = ./lua;
  };
}
