{ ... }: {
  flake = {
    modules.homeManager.terminal = { pkgs, ... }: {
      home.packages = [ pkgs.nerd-fonts.bitstream-vera-sans-mono ];

      programs.kitty = {
        enable = true;
        settings = {
          font_family = "BitstromWera Nerd Font";
          font_size = 12.0;
          window_padding_width = 12;
          background_opacity = "1.0";
          background_blur = 32;
          hide_window_decorations = "yes";
          cursor_shape = "block";
          cursor_blink_interval = 1;
          scrollback_lines = 3000;
          copy_on_select = "yes";
          strip_trailing_spaces = "smart";
          tab_bar_style = "powerline";
          tab_bar_align = "left";
          shell_integration = "enabled";
        };
        keybindings = {
          "ctrl+shift+n" = "new_window";
          "ctrl+t" = "new_tab";
          "ctrl+plus" = "change_font_size all +1.0";
          "ctrl+minus" = "change_font_size all -1.0";
          "ctrl+0" = "change_font_size all 0";
        };
        extraConfig = ''
          include ~/.config/kitty/dank-tabs.conf
          include ~/.config/kitty/dank-theme.conf
        '';
      };
    };
  };
}
