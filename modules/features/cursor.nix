{ ... }: {
  flake = {
    modules.homeManager.cursor = { pkgs, ... }: {
      home.pointerCursor = {
        gtk.enable = true;
        name = "Bibata-Modern-Amber";
        package = pkgs.bibata-cursors;
        size = 24;
      };

      wayland.windowManager.niri.settings.cursor = {
        xcursor-theme = "Bibata-Modern-Amber";
        xcursor-size = 24;
      };
    };
  };
}
