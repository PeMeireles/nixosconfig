vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
local servers = {}

if vim.fn.executable("lua-language-server") == 1 then
  vim.lsp.config("lua_ls", { capabilities = capabilities })
  table.insert(servers, "lua_ls")
end

if vim.fn.executable("marksman") == 1 then
  vim.lsp.config("marksman", { capabilities = capabilities })
  table.insert(servers, "marksman")
end

if vim.fn.executable("typescript-language-server") == 1 then
  vim.lsp.config("ts_ls", { capabilities = capabilities })
  table.insert(servers, "ts_ls")
end

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
if vim.fn.executable("nixd") == 1 then
  table.insert(servers, "nixd")
end
vim.lsp.enable(servers)

if vim.fn.exists(":LspInfo") == 0 then
  vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("checkhealth vim.lsp")
  end, { desc = "Show native LSP health information" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local map = function(keys, fn, desc, mode)
      vim.keymap.set(mode or "n", keys, fn, {
        buffer = event.buf,
        silent = true,
        desc = "LSP: " .. desc,
      })
    end

    map("K", vim.lsp.buf.hover, "Hover")
    map("gd", require("fzf-lua").lsp_definitions, "Goto definition")
    map("gr", require("fzf-lua").lsp_references, "Goto references")
    map("gI", require("fzf-lua").lsp_implementations, "Goto implementation")
    map("gD", vim.lsp.buf.declaration, "Goto declaration")
    map("<leader>D", require("fzf-lua").lsp_typedefs, "Type definition")
    map("<leader>ds", require("fzf-lua").lsp_document_symbols, "Document symbols")
    map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "Workspace symbols")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight") then
      local group = vim.api.nvim_create_augroup("lsp-document-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client and client:supports_method("textDocument/inlayHint") then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
      end, "Toggle inlay hints")
    end
  end,
})
