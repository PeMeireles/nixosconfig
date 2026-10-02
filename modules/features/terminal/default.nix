{ ... }: {
  flake.nixosModules.terminal = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.kitty
      pkgs.opencode
    ];
  };
}
