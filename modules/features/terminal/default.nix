{ ... }: {
  flake.modules.nixos.terminal = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.kitty
      pkgs.opencode
    ];
  };
}
