vim.pack.add {
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-tree/nvim-tree.lua",
}

require("nvim-tree").setup {
  update_focused_file = {
    enable = true,
  },

  filters = {
    git_ignored = false,
    custom = { "^\\.DS_Store$" },
  },
}

vim.keymap.set("n", "<D-e>", function()
  require("nvim-tree.api").tree.toggle { focus = false }
end, { silent = true })
