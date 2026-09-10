vim.pack.add { "https://github.com/stevearc/conform.nvim" }

require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    php = { "pint" },
  },
}

vim.keymap.set("n", "<D-f>", function()
  require("conform").format { async = true, lsp_format = "fallback" }
end)
