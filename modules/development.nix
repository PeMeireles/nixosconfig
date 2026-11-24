{inputs, ...}: {
  perSystem = {lib, pkgs, system, ...}: let
    supportedT3Code = system == "x86_64-linux";
    packagePkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    t3code = packagePkgs.appimageTools.wrapType2 {
      pname = "t3code";
      version = "0.1.1";
      src = packagePkgs.fetchurl {
        url = "https://github.com/pingdotgg/t3code/releases/download/v0.1.1/T3-Code-0.1.1-x86_64.AppImage";
        hash = "sha256-+KtS/hDvPLhyoIPQOP0SDdHsW0mP71aNBLKLenLGDDc=";
      };
    };
    sharedNvim = import ../lib/neovim.nix {pkgs = packagePkgs;};
    nvim = packagePkgs.neovim.override {
      configure = {
        customRC = ''
          set runtimepath^=${./features/apps/neovim}
          lua require("init")
        '';
        packages.nvim.start = sharedNvim.plugins;
      };
    };
    nvimApp = packagePkgs.writeShellApplication {
      name = "nvim";
      runtimeInputs = sharedNvim.tools;
      text = ''
        exec ${nvim}/bin/nvim "$@"
      '';
    };
  in {
    formatter = pkgs.alejandra;

    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        lua-language-server
        marksman
        nixd
        stylua
      ] ++ lib.optionals supportedT3Code [t3code];
    };

    packages = {inherit nvim;} // lib.optionalAttrs supportedT3Code {inherit t3code;};
    apps = {
      nvim = {
        type = "app";
        program = "${nvimApp}/bin/nvim";
        meta.description = "Portable Neovim configuration";
      };
    } // lib.optionalAttrs supportedT3Code {
      t3code = {
        type = "app";
        program = "${t3code}/bin/t3code";
        meta.description = "T3 Code desktop app";
      };
    };
  };
}
