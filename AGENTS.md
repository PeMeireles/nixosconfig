# Repository Guidelines: NixOS Configuration

## System Environment
- This repository is a NixOS flake-based system configuration.
- The `nixos` MCP server is available (`nix` and `nix_versions` lazy tools) for Nix-related queries and operations.

## Constraints & Best Practices
- **Do NOT inspect or traverse `/nix/store` directly**: Avoid running commands like `find /nix/store/...`, `ls /nix/store/...`, or reading files within `/nix/store`. This avoids heavy token consumption, permission denials, and context clutter.
- **Use Nix Tooling Instead**:
  - Use `nix eval`, `nix search`, `nix build`, or `nix flake check` to inspect packages and verify outputs.
  - Inspect module options or package metadata via `nix eval` or the `nixos` MCP server.
- **Do NOT modify the examples**: Those examples are provided for reference and should not be altered. Use them as templates for your own configurations.
