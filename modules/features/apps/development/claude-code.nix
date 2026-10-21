{...}: {
  flake.modules.homeManager.claude-code = {
    programs.claude-code = {
      enable = true;
      enableMcpIntegration = true;

      context = ''
        Do not over-plan. For simple tasks, make the change directly. Avoid
        unnecessary exploration, questions, and design documents unless asked.
        Default to action.

        Never commit. When changes are ready to commit, stop and tell me.
        Never add AI attribution to commit messages, PRs, or PR titles.
        Only write a long-form commit body when I explicitly ask; otherwise use
        a single-line commit message.

        This system runs NixOS. Use `, <package>` to run a package ephemerally
        with nix-index, or `nix-shell -p <package>` for a temporary shell.
        Use Context7 MCP for current library and framework documentation.

        When citing online sources, provide raw URLs rather than Markdown links.
        When giving me a command to run, copy it to the clipboard with
        `printf '<command>' | wl-copy` and show the command in a code block.
      '';

      settings = {
        enabledPlugins = {
          "pr-review-toolkit@claude-plugins-official" = true;
          "superpowers@claude-plugins-official" = true;
        };

        includeCoAuthoredBy = false;
        model = "sonnet";
        permissions = {
          defaultMode = "auto";
          deny = [
            "Bash(git commit*)"
            "Bash(nixos-rebuild switch*)"
          ];
        };
        showThinkingSummaries = true;
        skipAutoPermissionsPrompt = true;
      };
    };
  };
}
