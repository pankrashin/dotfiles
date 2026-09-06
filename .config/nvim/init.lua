
-- Disable default file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable default mode indicator
vim.o.showmode = false

-- Disable swap files as this config autosaves everything
vim.opt.swapfile = false

-- Autosave files
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "BufLeave" }, {
  command = "silent! wa",
})

-- Enable 24-bit RGB color support
vim.opt.termguicolors = true

-- Enable line numbers
vim.wo.number = true
vim.wo.relativenumber = false

-- Enable scrolloff
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

-- Enable mouse mode
vim.o.mouse = "a"

-- Mouse scroll by one line
vim.opt.mousescroll = "ver:1,hor:1"

-- Sync clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- Keep working directory fixed
vim.o.autochdir = false

-- Highlight line where cursor is
vim.o.cursorline = true

-- Save undo history
vim.o.undofile = true

-- Set tab to 4 spaces
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Enable smart indent
vim.o.smartindent = true

-- Render spaces as "·"
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ',space = '·', trail = '·', nbsp = '␣' }

-- Set folding to manual mode
vim.o.foldmethod = "manual"

-- Enable break indent
vim.o.breakindent = true

-- Make search case-insensitive unless \C or capital in search query
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show matches as you type search query
vim.o.incsearch = true

-- Set custom tab title
vim.opt.title = true

function GetCurrentIconFile()
  local filename = vim.fn.expand "%:t"
  local icon = require("nvim-web-devicons").get_icon(filename)
  return icon or ""
end

function GetTabTitle()
  local bufname = vim.fn.expand "%"
  local filetype = vim.bo.filetype

  -- Check if current buffer is nvim-tree
  if filetype == "NvimTree" or bufname:match "NvimTree" then
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return " " .. cwd_name
  end

  -- Check if current buffer is toggleterm
  if filetype == "toggleterm" then
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    -- Access the buffer-local variable for the terminal ID
    local term_id = vim.b.toggle_number
    return cwd_name .. "  Terminal " .. term_id
  end

  -- Default: show parent folder, icon, and filename
  local parent = vim.fn.fnamemodify(vim.fn.expand "%:p:h", ":t")
  local icon = GetCurrentIconFile()
  local filename = vim.fn.expand "%:t"

  return parent .. " " .. icon .. " " .. filename
end

vim.o.titlestring = "%{%v:lua.GetTabTitle()%}"

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}

-- lazy.nvim
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup("plugins", {})

-- color theme
vim.cmd("colorscheme cyberdream")

-- Load keymaps
vim.g.kitty_fast_forwarded_modifiers = "super"
require "keymaps"

-- nvim-treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})
