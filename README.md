## Run Neovim

From this repo:

```sh
nix run .#nvim
```

Or from GitHub:

```sh
nix run github:PeMeireles/nixosconfig/main#nvim
```

The GitHub command uses the committed version. Add `--refresh` after `run` if
Nix is using an old cached version.

## Neovim

- **Plugins and tools:** `lib/neovim.nix`
- **Language servers:** `modules/features/apps/neovim/lua/lsp.lua`
- **Plugin settings and formatters:** `modules/features/apps/neovim/lua/plugins.lua`
- **Keybindings:** `modules/features/apps/neovim/lua/keymap.lua`

### Add a language server

Add its package to the `tools` list in `lib/neovim.nix`, then enable it in
`lsp.lua`. For example, for Go, add `gopls` and `go` to `tools`, then add this
before `vim.lsp.enable(servers)`:

```lua
if vim.fn.executable("gopls") == 1 then
  vim.lsp.config("gopls", { capabilities = capabilities })
  table.insert(servers, "gopls")
end
```

Run `nix run .#nvim` again or rebuild the laptop. Open a project and use
`:LspInfo` to check that the server attached. TypeScript is already configured;
add `typescript-language-server` and `typescript` to `tools` to enable it.
Bash, Fish, Rust and Python are also configured to use `bash-language-server`,
`fish-lsp`, `rust-analyzer` and `pyright` when available.

For a formatter, add its package to `tools` and its filetype to
`formatters_by_ft` in `plugins.lua`. For a plugin, add it to `plugins` in
`lib/neovim.nix` and configure it in `plugins.lua` if needed.

Changes to these shared lists apply to both the portable editor and the laptop's
Home Manager editor. Nix may need to download or build the added packages.

### Project-specific tools

You don't have to install every language server globally. Add the tools you
need to each project's flake instead. For example, a TypeScript project's
`flake.nix` could have:

```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs
        typescript
        typescript-language-server
      ];
    };
  };
}
```

From the project directory, enter the shell and start Neovim:

```sh
nix develop -c fish
nvim
```

For Bash, Fish, Rust or Python, add `bash-language-server`, `fish-lsp`,
`rust-analyzer` or `pyright` to that project's shell instead. Their Neovim
configurations are already in place; they start when the server is available.

If you use direnv with nix-direnv, put `use flake` in the project's `.envrc`
and run `direnv allow` once. The shell then loads when you enter the directory.
Start Neovim after it loads, and use `:LspInfo` to check the server.

## Clean up

```sh
nix store gc --dry-run  # preview
nix store gc            # remove unused store paths
```
