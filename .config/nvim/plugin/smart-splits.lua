vim.pack.add({'https://github.com/mrjones2014/smart-splits.nvim'})

require('smart-splits').setup({
    cursor_follows_swapped_bufs = true,
})

-- resizing splits
vim.keymap.set('n', '<C-A-D-left>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-A-D-down>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-A-D-up>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-A-D-right>', require('smart-splits').resize_right)

-- moving between splits
vim.keymap.set('n', '<D-left>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<D-down>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<D-up>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<D-right>', require('smart-splits').move_cursor_right)

-- swapping buffers between windows
vim.keymap.set('n', '<C-A-left>', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<C-A-down>', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<C-A-up>', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<C-A-right>', require('smart-splits').swap_buf_right)
