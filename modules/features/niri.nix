{ self, inputs, ... }: {
    flake.nixosModules.dms = { pkgs, ... }: {
        imports = [ inputs.dms.nixosModules.dank-material-shell ];

        programs.dank-material-shell = {
            enable = true;
            package = inputs.dms.packages.${pkgs.system}.dms-shell;
            systemd.enable = true;
        };
    };

    flake.nixosModules.dankGreeter = { ... }: {
        imports = [ inputs.dank-greeter.nixosModules.default ];

        programs.dms-greeter = {
            enable = true;
            compositor.name = "niri";
            configHome = "/home/vepelozi";
        };
    };

    flake.nixosModules.niri = {  pkgs, lib, ... }: {
        programs.niri = {
	    enable = true;
	    package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
        };
    };
    perSystem = { pkgs, lib, ... }: {
	packages.dms = inputs.dms.packages.${pkgs.system}.dms-shell;

	packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
	    inherit pkgs;
	    settings = {
	    config.kdl.content = builtins.readFile ../../.config/niri/config.kdl;
	    };

	};
    };
}
