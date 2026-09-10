-- enable lua module loader
vim.loader.enable()

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- use system clipboard
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- disable swap files
vim.opt.swapfile = false

-- autosave files
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "BufLeave" }, {
  command = "silent! wa",
})

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable 24-bit colour
vim.opt.termguicolors = true

-- show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- scrolloff
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", space = "·" }

-- line wrap
vim.opt.wrap = false

-- tab
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- enable smart indentation
vim.opt.smartindent = true

-- incremental search
vim.opt.incsearch = true

-- case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

-- save undo history
vim.opt.undofile = true

-- enable mouse
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true

vim.opt.undofile = true

vim.g.have_nerd_font = true

vim.opt.completeopt = "menuone,longest,preview"

require "title"
require "keymaps"
