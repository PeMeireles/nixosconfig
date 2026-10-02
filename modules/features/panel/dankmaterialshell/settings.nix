{ ... }: {
  flake = {
    modules.homeManager.dms-settings = {
      programs.dank-material-shell = {
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
  };
}
