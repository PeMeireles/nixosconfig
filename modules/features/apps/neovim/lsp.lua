vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  virtual_text = { source = "if_many", spacing = 2 },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("lua_ls", { capabilities = capabilities })
vim.lsp.config("marksman", { capabilities = capabilities })
vim.lsp.config("nixd", {
  capabilities = capabilities,
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> {}",
      },
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})
vim.lsp.enable({ "lua_ls", "marksman", "nixd" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", require("fzf-lua").lsp_definitions, opts)
    vim.keymap.set("n", "gr", require("fzf-lua").lsp_references, opts)
    vim.keymap.set("n", "gI", require("fzf-lua").lsp_implementations, opts)
    vim.keymap.set("n", "<leader>D", require("fzf-lua").lsp_typedefs, opts)
    vim.keymap.set("n", "<leader>ds", require("fzf-lua").lsp_document_symbols, opts)
    vim.keymap.set("n", "<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
