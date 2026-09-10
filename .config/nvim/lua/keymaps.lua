-- unmap space
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- write buffer
vim.keymap.set("n", "<D-s>", ":w<CR>", { silent = true })

-- search buffer
vim.keymap.set("n", "<D-f>", "/")

-- select entire buffer
vim.keymap.set("n", "<D-a>", "ggVG", {})

-- navigation between paragraphs
vim.keymap.set("n", "<A-down>", ":keepjumps normal! }<CR>", { silent = true, remap = true })
vim.keymap.set("v", "<A-down>", "}", { silent = true, remap = true })
vim.keymap.set("n", "<A-up>", ":keepjumps normal! {<CR>", { silent = true, remap = true })
vim.keymap.set("v", "<A-up>", "{", { silent = true, remap = true })

-- remap b and w for horizontal word movement
vim.keymap.set({ "n", "v" }, "<A-left>", "b")
vim.keymap.set({ "n", "v" }, "<A-right>", "w")

-- move lines
vim.keymap.set("n", "<A-D-down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("x", "<A-D-down>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<A-D-up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("x", "<A-D-up>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true })

-- jump to the end of the line
vim.keymap.set({ "n", "v" }, "-", "$", { silent = true })

-- splits
vim.keymap.set("n", "<D-d>", ":vs<CR>", { silent = true, nowait = true })
vim.keymap.set("n", "<S-D-d>", ":sp<CR>", { silent = true, nowait = true })

-- comment lines
vim.keymap.set("n", "<D-/>", "gcc", { remap = true })
vim.keymap.set("v", "<D-/>", "gc", { remap = true })

vim.keymap.set("n", "<backspace>", '"_dh', { noremap = true })
vim.keymap.set("v", "<backspace>", '"_d', { noremap = true })

vim.keymap.set({ "n", "i", "x", "o", "s", "t" }, "<D-w>", "<Cmd>confirm quit<CR>")
