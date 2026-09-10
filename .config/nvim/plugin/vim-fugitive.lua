vim.pack.add { "https://github.com/tpope/vim-fugitive" }

vim.keymap.set("n", "<D-g>", ":above Git<CR>", { silent = true })
