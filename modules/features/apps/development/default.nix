{self, ...}: {
  flake.modules.homeManager.development.imports = [
    self.modules.homeManager.mcp
    self.modules.homeManager.claude-code
    self.modules.homeManager.codex
  ];
}
