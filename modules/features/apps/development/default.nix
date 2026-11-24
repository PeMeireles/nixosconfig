{self, ...}: {
  flake.modules.homeManager.development.imports = [
    self.modules.homeManager.mcp
    self.modules.homeManager.claude-code
    self.modules.homeManager.codex
    self.modules.homeManager.t3code
    self.modules.homeManager.rustup
  ];
}
