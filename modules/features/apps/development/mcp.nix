{...}: {
  flake.modules.homeManager.mcp = {
    lib,
    pkgs,
    ...
  }: let
    context7 = pkgs.writeShellScript "context7-mcp" ''
      export PATH="${pkgs.nodejs}/bin:$PATH"
      exec npx -y @upstash/context7-mcp@4.4.4
    '';
  in {
    programs.mcp = {
      enable = true;

      servers = {
        context7.command = toString context7;
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
  };
}
