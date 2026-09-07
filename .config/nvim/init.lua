vim.loader.enable()

vim.opt.termguicolors = true

-- disable swap files as this config autosaves everything
vim.opt.swapfile = false

-- autosave files
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "BufLeave" }, {
  command = "silent! wa",
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.undofile = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.smartindent = true

vim.o.wrap = false

require 'title'
require "keymaps"
