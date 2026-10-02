{ ... }: {
  flake = {
    modules.homeManager.dms-niri = {
      wayland.windowManager.niri.settings.layer-rule = [
        {
          match._props.namespace = "^quickshell$";
          place-within-backdrop = true;
        }
      ];
    };
  };
}
