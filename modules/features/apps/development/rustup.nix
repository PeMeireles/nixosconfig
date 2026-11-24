{...}: {
  flake.modules.homeManager.rustup = {pkgs, ...}: {
    home.packages = [
      pkgs.rustup
    ];

    home.sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };
}
