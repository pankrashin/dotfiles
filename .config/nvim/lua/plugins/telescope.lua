return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-media-files.nvim",
  },

  config = function()
    require("telescope").setup {
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key",
          },
        },
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          -- find command (defaults to `fd`)
          find_cmd = "rg",
        },
      },
    }

    require("telescope").load_extension "media_files"
    -- require("telescope").load_extension "projects"

    local builtin = require "telescope.builtin"
    -- vim.keymap.set("n", "ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "fg", builtin.live_grep, { desc = "Telescope live grep" })
    -- vim.keymap.set("n", "fb", builtin.buffers, { desc = "Telescope buffers" })
    -- vim.keymap.set("n", "ft", builtin.help_tags, { desc = "Telescope help tags" })
    -- vim.keymap.set("n", "fm", builtin.media_files, { desc = "Telescope help tags" })
  end,
}
