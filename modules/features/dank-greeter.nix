{ inputs, ... }: {
  flake.modules.nixos.dankGreeter = { ... }: {
    imports = [ inputs.dank-greeter.nixosModules.default ];

    programs.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/vepelozi";
    };
  };
}
