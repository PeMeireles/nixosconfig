{ ... }: {
  flake.modules.homeManager.default-apps = { pkgs, ... }: {
    home.packages = [
      pkgs.firefox
    ];

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.kde.dolphin.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };

    xdg.configFile."mimeapps.list".force = true;
  };
}
