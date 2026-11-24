{ ... }: {
  flake = {
    modules.nixos.dolphin = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.kdePackages.qtsvg ];
    };

    modules.homeManager.dolphin = { pkgs, ... }: {
      home.packages = [ pkgs.kdePackages.dolphin ];
    };
  };
}
