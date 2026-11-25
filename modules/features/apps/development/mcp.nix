{...}: {
  flake.modules.homeManager.mcp = {
    lib,
    pkgs,
    ...
  }: let
    context7Skill = ./skills/context7-mcp/SKILL.md;
    context7Rule = ''
      Use Context7 MCP for current library and framework documentation.
    '';
  in {
    programs.mcp = {
      enable = true;

      servers = {
        context7.url = "https://mcp.context7.com/mcp/oauth";
        nixos.command = lib.getExe pkgs.mcp-nixos;
        zotero = {
          command = "${pkgs.uv}/bin/uvx";
          args = [
            "--python"
            "${pkgs.python3}/bin/python3"
            "--no-python-downloads"
            "--from"
            "zotero-mcp-server==0.15.1"
            "zotero-mcp"
            "serve"
            "--transport"
            "stdio"
          ];
          env = {
            ZOTERO_LOCAL = "true";
            ZOTERO_API_KEY = "";
            ZOTERO_NO_CLAUDE = "true";
          };
        };
      };
    };

    programs.codex.skills.context7-mcp = context7Skill;
    programs.claude-code.skills.context7-mcp = context7Skill;
    programs.opencode.context = context7Rule;
    programs.opencode.skills.context7-mcp = context7Skill;
    programs.antigravity-cli.context.GEMINI = context7Rule;
    programs.antigravity-cli.skills.context7-mcp = context7Skill;
  };
}
