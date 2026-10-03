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
        keymap = { preset = "default" },
        completion = { documentation = { auto_show = true } },
        signature = { enabled = true },
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
    after = function()
      require("which-key").setup({})
      vim.keymap.set("n", "<leader>?", function()
        require("which-key").show({ global = false })
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
  { "noice.nvim" },
})
