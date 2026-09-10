vim.pack.add {
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-web-devicons",
  "https://github.com/stevearc/aerial.nvim",
}

require("aerial").setup {
  on_attach = function(bufnr)
    vim.keymap.set("n", "<D-[>", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<D-]>", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
}

vim.keymap.set("n", "<D-o>", "<cmd>AerialToggle!<CR>")
