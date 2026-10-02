{ ... }: {
  flake = {
    modules.homeManager.niri-settings = {
      wayland.windowManager.niri.settings = {
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
            offset._props = { x = 0; y = 5; };
            color = "#0000";
          };
        };
        overview.workspace-shadow.off = [];
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
        animations = {
          workspace-switch.spring._props = {
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
          horizontal-view-movement.spring._props = {
            damping-ratio = 0.85;
            stiffness = 423;
            epsilon = 0.0001;
          };
          window-movement.spring._props = {
            damping-ratio = 0.75;
            stiffness = 323;
            epsilon = 0.0001;
          };
          window-resize.spring._props = {
            damping-ratio = 0.85;
            stiffness = 423;
            epsilon = 0.0001;
          };
        };
      };
    };
  };
}
