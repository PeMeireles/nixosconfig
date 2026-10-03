{ ... }:
{
  flake.modules.homeManager.neovim = { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        initLua = ''
          require("init")
        '';

        extraPackages = with pkgs; [
          lua-language-server
          marksman
          nixd
          alejandra
          stylua
          prettierd
        ];

        plugins = with pkgs.vimPlugins; [
          lz-n
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
          vim-sleuth
          blink-cmp
          snacks-nvim
          oil-nvim
          fzf-lua
          conform-nvim
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

      xdg.configFile."nvim/lua".source = ./neovim;
    };
}
