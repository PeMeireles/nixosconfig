{ inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };

  flake = {
    modules.homeManager.niri = { pkgs, ... }: {
      imports = [ inputs.niri-nix.homeModules.default ];
      wayland.windowManager.niri = {
        enable = true;
        package = pkgs.niri;
        settings = {
          input.keyboard.xkb.layout = "pt";
          input.keyboard.xkb.variant = "";
          gestures.hot-corners = { top-left = []; top-right = []; };
          hotkey-overlay.skip-at-startup = [];
          prefer-no-csd = true;
          environment.XDG_CURRENT_DESKTOP = "niri";
          layout = {
            background-color = "transparent";
            center-focused-column = "never";
            default-column-width.proportion = 0.5;
            gaps = 4;
            border.off = [];
          };
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
          spawn-at-startup = [ [ "dms" "run" ] ];
          binds = {
            "Mod+T".spawn = [ "kitty" ];
            "Mod+Space".spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ];
            "Mod+N".spawn = [ "dms" "ipc" "call" "notifications" "toggle" ];
            "Mod+Comma".spawn = [ "dms" "ipc" "call" "settings" "focusOrToggle" ];
            "Mod+V".spawn = [ "dms" "ipc" "call" "clipboard" "toggle" ];
            "Mod+Alt+L".spawn = [ "dms" "ipc" "call" "lock" "lock" ];
            "Mod+Shift+T".toggle-window-floating = [];
            "Mod+D".toggle-overview = [];
            "Mod+Tab".toggle-overview = [];
            "Mod+Q".close-window = [];
            "Mod+Shift+E".quit = [];
          };
        };
      };
    };
  };
}
