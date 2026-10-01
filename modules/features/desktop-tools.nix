{ ... }: {
  flake.nixosModules.desktopTools = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.kitty
      pkgs.opencode
    ];

    # The base config is immutable; DMS-generated theme files stay in the
    # user's ~/.config/kitty and remain writable.
    environment.etc."xdg/kitty".source = ../../.config/kitty;
  };
}
