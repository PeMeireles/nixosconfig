{inputs, ...}: {
  flake.modules.homeManager.t3code = {pkgs, ...}: {
    home.packages = [
      inputs.t3code.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.antigravity-cli = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.antigravity-cli;
      enableMcpIntegration = true;
    };
  };
}
