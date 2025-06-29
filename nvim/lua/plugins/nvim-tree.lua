return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = {
            "^.DS_Store$",
          },
        },
      })
      
      vim.keymap.set("n", "<D-b>", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
      
      -- Always open nvim-tree when Neovim starts
      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          require("nvim-tree.api").tree.open()
        end,
      })
    end,
  },
}
