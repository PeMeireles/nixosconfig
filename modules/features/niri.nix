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
          input.keyboard.numlock = [];
          input.touchpad = {
            tap = [];
            natural-scroll = [];
          };
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
            shadow = {
              softness = 30;
              spread = 5;
              offset = { x = 0; y = 5; };
              color = "#0000";
            };
          };
          layer-rule = [
            {
              matches = [ { namespace = "^quickshell$"; } ];
              place-within-backdrop = true;
            }
          ];
          overview.workspace-shadow.off = [];
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
          animations = {
            workspace-switch.spring = {
              damping-ratio = 0.80;
              stiffness = 523;
              epsilon = 0.0001;
            };
            window-open = {
              duration-ms = 150;
              curve = "ease-out-expo";
            };
            window-close = {
              duration-ms = 150;
              curve = "ease-out-quad";
            };
            horizontal-view-movement.spring = {
              damping-ratio = 0.85;
              stiffness = 423;
              epsilon = 0.0001;
            };
            window-movement.spring = {
              damping-ratio = 0.75;
              stiffness = 323;
              epsilon = 0.0001;
            };
            window-resize.spring = {
              damping-ratio = 0.85;
              stiffness = 423;
              epsilon = 0.0001;
            };
          };
          spawn-at-startup = [ [ "dms" "run" ] ];
          binds = {
            "Mod+T".spawn = [ "kitty" ];
            "Mod+Space".spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ];
            "Mod+N".spawn = [ "dms" "ipc" "call" "notifications" "toggle" ];
            "Mod+Comma".spawn = [ "dms" "ipc" "call" "settings" "focusOrToggle" ];
            "Mod+V".spawn = [ "dms" "ipc" "call" "clipboard" "toggle" ];
            "Mod+Alt+L".spawn = [ "dms" "ipc" "call" "lock" "lock" ];
            "Mod+Shift+T".toggle-window-floating = [];
            "Mod+Q".close-window = [];
            "Mod+Shift+E".quit = [];

            # Workspaces
            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;
            "Mod+Shift+1".move-column-to-workspace = 1;
            "Mod+Shift+2".move-column-to-workspace = 2;
            "Mod+Shift+3".move-column-to-workspace = 3;
            "Mod+Shift+4".move-column-to-workspace = 4;
            "Mod+Shift+5".move-column-to-workspace = 5;
            "Mod+Shift+6".move-column-to-workspace = 6;
            "Mod+Shift+7".move-column-to-workspace = 7;
            "Mod+Shift+8".move-column-to-workspace = 8;
            "Mod+Shift+9".move-column-to-workspace = 9;
            "Mod+I".focus-workspace-up = [];
            "Mod+U".focus-workspace-down = [];
            "Mod+Shift+I".move-workspace-up = [];
            "Mod+Shift+U".move-workspace-down = [];
            "Mod+Page_Up".focus-workspace-up = [];
            "Mod+Page_Down".focus-workspace-down = [];
            "Mod+Shift+Page_Up".move-workspace-up = [];
            "Mod+Shift+Page_Down".move-workspace-down = [];

            # Focus and move windows
            "Mod+H".focus-column-left = [];
            "Mod+J".focus-window-down = [];
            "Mod+K".focus-window-up = [];
            "Mod+L".focus-column-right = [];
            "Mod+Left".focus-column-left = [];
            "Mod+Right".focus-column-right = [];
            "Mod+Up".focus-window-up = [];
            "Mod+Down".focus-window-down = [];
            "Mod+Shift+H".move-column-left = [];
            "Mod+Shift+J".move-window-down = [];
            "Mod+Shift+K".move-window-up = [];
            "Mod+Shift+L".move-column-right = [];
            "Mod+Shift+Left".move-column-left = [];
            "Mod+Shift+Right".move-column-right = [];
            "Mod+Shift+Up".move-window-up = [];
            "Mod+Shift+Down".move-window-down = [];
            "Mod+Ctrl+H".focus-monitor-left = [];
            "Mod+Ctrl+J".focus-monitor-down = [];
            "Mod+Ctrl+K".focus-monitor-up = [];
            "Mod+Ctrl+L".focus-monitor-right = [];
            "Mod+Ctrl+Left".focus-monitor-left = [];
            "Mod+Ctrl+Right".focus-monitor-right = [];
            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = [];
            "Mod+Shift+Ctrl+J".move-column-to-monitor-down = [];
            "Mod+Shift+Ctrl+K".move-column-to-monitor-up = [];
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = [];
            "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = [];
            "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = [];
            "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = [];
            "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = [];

            # Columns and windows
            "Mod+BracketLeft".consume-or-expel-window-left = [];
            "Mod+BracketRight".consume-or-expel-window-right = [];
            "Mod+C".center-column = [];
            "Mod+Ctrl+C".center-visible-columns = [];
            "Mod+F".maximize-column = [];
            "Mod+Alt+Space".toggle-window-floating = [];
            "Mod+Shift+F".fullscreen-window = [];
            "Mod+Shift+V".switch-focus-between-floating-and-tiling = [];
            "Mod+W".toggle-column-tabbed-display = [];
            "Mod+Period".expel-window-from-column = [];
            "Mod+R".switch-preset-column-width = [];
            "Mod+Shift+R".switch-preset-window-height = [];
            "Mod+Equal".set-column-width = "+10%";
            "Mod+Minus".set-column-width = "-10%";
            "Mod+Plus".set-window-width = "+10%";
            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Plus".set-window-height = "+10%";
            "Mod+Ctrl+F".expand-column-to-available-width = [];
            "Mod+Ctrl+R".reset-window-height = [];
            "Mod+Shift+P".power-off-monitors = [];

            # Scrolling and overview
            "Mod+WheelScrollDown".focus-workspace-down = [];
            "Mod+WheelScrollUp".focus-workspace-up = [];
            "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = [];
            "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = [];
            "Mod+Shift+WheelScrollDown".focus-column-right = [];
            "Mod+Shift+WheelScrollUp".focus-column-left = [];
            "Mod+Ctrl+WheelScrollLeft".move-column-left = [];
            "Mod+Ctrl+WheelScrollRight".move-column-right = [];
            "Mod+Tab".toggle-overview = [];
            "Mod+D".toggle-overview = [];

            # Screenshots and session
            "Print".screenshot = [];
            "Ctrl+Print".screenshot-screen = [];
            "Alt+Print".screenshot-window = [];
            "Mod+Shift+Slash".show-hotkey-overlay = [];
            "Mod+Escape" = {
              _props.allow-inhibiting = false;
              toggle-keyboard-shortcuts-inhibit = [];
            };

            # DMS media and brightness controls
            "XF86AudioLowerVolume" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "decrement" "3" ]; };
            "XF86AudioRaiseVolume" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "increment" "3" ]; };
            "XF86AudioMute" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "mute" ]; };
            "XF86AudioMicMute" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "micmute" ]; };
            "XF86MonBrightnessDown" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "brightness" "decrement" "5" "" ]; };
            "XF86MonBrightnessUp" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "brightness" "increment" "5" "" ]; };
            "XF86AudioPlay" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "playPause" ]; };
            "XF86AudioPause" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "playPause" ]; };
            "XF86AudioNext" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "next" ]; };
            "XF86AudioPrev" = { _props.allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "previous" ]; };
          };
        };
      };
    };
  };
}
