require("lz.n").load({
  {
    "nvim-treesitter",
    after = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    "blink.cmp",
    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          ["<C-q>"] = { "accept", "fallback" },
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = { documentation = { auto_show = true } },
        signature = { enabled = true },
        sources = {
          default = { "lsp", "path", "snippets", "copilot", "buffer", "emoji", "sql" },
          providers = {
            emoji = {
              module = "blink-emoji",
              name = "Emoji",
              score_offset = -4,
              opts = { insert = true },
            },
            sql = {
              name = "sql",
              module = "blink.compat.source",
              score_offset = -3,
              opts = {},
              should_show_items = function()
                return vim.tbl_contains({ "sql" }, vim.o.filetype)
              end,
            },
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              score_offset = -2,
              async = true,
              opts = { max_completions = 3 },
            },
          },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      })
    end,
  },
  {
    "blink.compat",
    lazy = false,
    after = function()
      require("blink.compat").setup({})
    end,
  },
  {
    "copilot.lua",
    lazy = false,
    after = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = { markdown = true, help = true },
      })
    end,
  },
  { "oil.nvim", after = function() require("oil").setup({}) end },
  {
    "conform.nvim",
    after = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          nix = { "alejandra" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
      })
    end,
  },
  {
    "snacks.nvim",
    after = function()
      require("snacks").setup({ picker = { enabled = true }, input = { enabled = true } })
    end,
  },
  {
    "project.nvim",
    lazy = false,
    after = function()
      require("project").setup({})
    end,
  },
  {
    "barbar.nvim",
    lazy = false,
    after = function()
      require("barbar").setup({})
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<Tab><Tab>", "<Cmd>BufferNext<CR>", opts)
      vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", opts)
      vim.keymap.set("n", "<Tab>w", "<Cmd>tabnew<CR>", opts)
      vim.keymap.set("n", "<Tab>d", "<Cmd>BufferClose<CR>", opts)
    end,
  },
  {
    "which-key.nvim",
    lazy = false,
    after = function()
      local which_key = require("which-key")
      which_key.setup({})
      which_key.add({
        { "<leader>c", group = "Code" },
        { "<leader>b", group = "Buffers" },
        { "<leader>d", group = "Document" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>p", group = "Project" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
        { "<leader>u", group = "UI" },
        { "<leader>w", group = "Workspace" },
        { "<leader>x", group = "Diagnostics" },
        { "gd", desc = "LSP: Goto definition" },
        { "gr", desc = "LSP: Goto references" },
        { "gI", desc = "LSP: Goto implementation" },
        { "gD", desc = "LSP: Goto declaration" },
        { "K", desc = "LSP: Hover documentation" },
        { "<leader>D", desc = "LSP: Type definition" },
        { "<leader>ds", desc = "LSP: Document symbols" },
        { "<leader>ws", desc = "LSP: Workspace symbols" },
        { "<leader>ca", desc = "LSP: Code action" },
        { "<leader>cr", desc = "LSP: Rename symbol" },
        { "<leader>cf", desc = "LSP: Format buffer" },
        { "<leader>th", desc = "LSP: Toggle inlay hints" },
      })
      vim.keymap.set("n", "<leader>?", function()
        which_key.show({ global = false })
      end, { desc = "Buffer local keymaps" })
    end,
  },
  {
    "nightfox.nvim",
    after = function()
      require("nightfox").setup({ transparent = true })
      vim.cmd.colorscheme("dawnfox")
    end,
  },
  {
    "showkeys",
    cmd = "ShowkeysToggle",
    after = function()
      require("showkeys").setup({ maxkeys = 5 })
    end,
  },
  { "mini.statusline" },
  { "nui.nvim", lazy = false },
  {
    "nvim-notify",
    lazy = false,
    after = function()
      require("notify").setup({})
    end,
  },
  {
    "noice.nvim",
    lazy = false,
    after = function()
      require("noice").setup({})
    end,
  },
})
