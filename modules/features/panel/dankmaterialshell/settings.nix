{ ... }: {
  flake.modules.homeManager.dms-settings = {
    programs.dank-material-shell = {
      settings = import ./new_settings.nixdata;
      session = import ./new_settings_session.nixdata;

      enableAudioWavelength = true;
      enableCalendarEvents = true;
      enableClipboardPaste = true;
      enableDynamicTheming = true;
      enableSystemMonitoring = true;
      enableVPN = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
  };
}
