{...}: {
  flake.modules.homeManager.codex = {
    config,
    lib,
    pkgs,
    ...
  }: let
    useXdgDirectories =
      config.home.preferXdgDirectories
      && lib.versionAtLeast (lib.getVersion config.programs.codex.package) "0.2.0";
    codexConfigFile =
      if useXdgDirectories
      then "/.config/codex/config.toml"
      else ".codex/config.toml";
    codexConfigTarget =
      if useXdgDirectories
      then "${config.xdg.configHome}/codex/config.toml"
      else "${config.home.homeDirectory}/.codex/config.toml";
    configPython = pkgs.python3.withPackages (ps: [ps.tomlkit]);
  in {
    home = {
      activation.codexSeedConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
        run ${configPython}/bin/python ${./codex/sync-config.py} \
          ${lib.escapeShellArg (toString config.home.file."${codexConfigFile}".source)} \
          ${lib.escapeShellArg codexConfigTarget}
      '';

      file."${codexConfigFile}".enable = false;
    };

    programs.codex = {
      enable = true;
      enableMcpIntegration = true;

      context = ''
        ## Working Style

        Do not over-plan. For simple tasks, make the change directly. Avoid
        unnecessary exploration, questions, and design documents unless asked.
        Default to action.

        ## Git

        Never commit unless I explicitly ask. When changes are ready to commit,
        stop and tell me. Never add AI attribution to commit messages, PRs, or PR
        titles. Use a single-line Conventional Commit message unless I ask for a
        long-form body.

        ## NixOS

        This system runs NixOS. Use `, <package>` to run a package ephemerally
        with nix-index, or `nix-shell -p <package>` for a temporary shell.
        The NixOS MCP can retrieve exact package and option documentation.
        Use Context7 MCP for current library and framework documentation.

        ## Response Formatting

        When citing online sources, provide raw URLs rather than Markdown links.
      '';

      rules.default = ''
        prefix_rule(
          pattern = ["git", "commit"],
          decision = "forbidden",
          justification = "Never commit unless I explicitly ask.",
        )

        prefix_rule(
          pattern = ["nixos-rebuild", "switch"],
          decision = "forbidden",
          justification = "Build the system and let me decide whether to switch.",
        )
      '';

      settings = {
        approval_policy = "on-request";
        check_for_update_on_startup = false;
        model = "gpt-5.6-luna";
        sandbox_mode = "workspace-write";
        tui.vim_mode_default = true;
      };
    };
  };
}
