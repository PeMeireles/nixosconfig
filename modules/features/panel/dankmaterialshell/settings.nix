{ ... }: {
  flake = {
    modules.homeManager.dms-settings = {
      programs.dank-material-shell = {
        settings.appIdSubstitutions = [
          {
            pattern = "Spotify";
            replacement = "spotify";
            type = "exact";
          }
        ];
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
