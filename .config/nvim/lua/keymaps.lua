-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- remap k and j for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- remap b and w for horizontal word movement
vim.keymap.set({ "n", "v" }, "<A-left>", "b", { silent = true })
vim.keymap.set({ "n", "v" }, "<A-right>", "w", { silent = true })

-- fast Vertical Navigation (thanks dmtrKovalenko)
vim.keymap.set("n", "<A-down>", "<cmd>keepjumps normal! }<cr>", { silent = true, remap = true })
vim.keymap.set("v", "<A-down>", "}", { silent = true, remap = true })
vim.keymap.set("n", "<A-up>", "<cmd>keepjumps normal! {<cr>", { silent = true, remap = true })
vim.keymap.set("v", "<A-up>", "{", { silent = true, remap = true })

-- jump to the end of the line
vim.keymap.set({ "n", "v" }, "-", "$", { silent = true })

-- Select whole buffer
vim.keymap.set("n", "<D-a>", "ggVG", {})

-- Copy
vim.keymap.set("v", "<D-c>", "y", {})

vim.keymap.set("n", "<D-g>", "<cmd>DiffviewOpen<cr>", { desc = "Open DiffView" })

-- Write
vim.keymap.set("n", "<D-s>", "<cmd>w<cr>", { desc = "Split window vertically" })

-- Split (divide) controls
vim.keymap.set("n", "<D-d>", "<cmd>rightbelow vsplit<cr>", { desc = "Split window vertically" })
vim.keymap.set("n", "<D-S-d>", "<cmd>rightbelow split<cr>", { desc = "Split window horizontally" })

-- moving between splits (smart-splits.nvim)
vim.keymap.set('n', '<D-Left>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<D-Down>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<D-Up>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<D-Right>', require('smart-splits').move_cursor_right)
-- vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)

-- resizing splits (smart-splits.nvim)
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
-- vim.keymap.set('n', '<C-A-D-Left>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-A-D-Down>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-A-D-Up>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-A-D-Right>', require('smart-splits').resize_right)

-- swapping buffers between windows (smart-splits.nvim)
vim.keymap.set('n', '<leader><leader><Left>', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader><Down>', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader><Up>', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader><Right>', require('smart-splits').swap_buf_right)

-- comment out lines (comment.nvim)
vim.keymap.set("n", "<D-/>", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<D-/>", "gc", { remap = true, desc = "Toggle comment selection" })

-- Formatting (conform.nvim)
vim.keymap.set({ "n", "v" }, "<D-f>", function()
  require("conform").format { lsp_format = "fallback" }
end, { desc = "Format file or range (in visual mode)" })

vim.keymap.set({ "n", "i" }, "<D-S-f>", "<cmd>ConformInfo<cr>", { desc = "Conform Info", silent = true })

vim.api.nvim_create_user_command("Format", function()
  require("conform").format { lsp_format = "fallback" }
end, { desc = "Format current buffer with conform" })

-- File explorer (nvim-tree)
vim.keymap.set("n", "<D-e>", function()
  require("nvim-tree.api").tree.toggle { focus = false }
end, { desc = "Toggle NvimTree without focus" })

-- Diagnostics
-- vim.keymap.set("n", "<D-e>", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<D-m>", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Terminal (toggleterm.nvim)
vim.keymap.set({ "n", "t" }, "<D-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- Add W command to mirror w because I mistype constantly
vim.api.nvim_create_user_command("W", "w", {})

vim.keymap.set({ 'n', 'i', 'x', 'o', 's', 't' }, '<D-w>', '<Cmd>confirm quit<CR>')
