{ inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };

  flake.homeModules.niri = { pkgs, ... }: {
    imports = [ inputs.niri-nix.homeModules.default ];

    wayland.windowManager.niri = {
      enable = true;
      package = pkgs.niri;
      settings = {
        input.keyboard.xkb.layout = "pt";
        input.keyboard.xkb.variant = "";

        gestures.hot-corners = {
          top-left = [];
          top-right = [];
        };

        hotkey-overlay.skip-at-startup = [];
        prefer-no-csd = true;
        environment.XDG_CURRENT_DESKTOP = "niri";

        layout = {
          background-color = "transparent";
          center-focused-column = "never";
          default-column-width.proportion = 0.5;
          gaps = 4;
          border.off = [];
          shadow = {
            softness = 30;
            spread = 5;
            offset = { x = 0; y = 5; };
            color = "#0000";
          };
        };

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        binds = {
          "Mod+T".spawn = [ "kitty" ];
          "Mod+Shift+T".toggle-window-floating = [];
          "Mod+D".toggle-overview = [];
          "Mod+Tab".toggle-overview = [];
          "Mod+Q".close-window = [];
          "Mod+Shift+E".quit = [];
        };
      };
    };
  };
}
