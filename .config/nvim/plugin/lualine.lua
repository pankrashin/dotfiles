vim.pack.add {
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
}

vim.opt.showmode = false
vim.opt.cmdheight = 0

require("lualine").setup()
