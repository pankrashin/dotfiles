vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter" }

require("nvim-treesitter").install { "lua", "php", "php_only", "phpdoc", "sql", "python", "swift" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php" },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "swift" },
  callback = function()
    vim.treesitter.start()
  end,
})
