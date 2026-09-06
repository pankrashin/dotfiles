return {
  "mrjones2014/smart-splits.nvim",
  dir = "~/smart-splits.nvim",

  build = "./kitty/install-kittens.bash",

  config = function()
    require("smart-splits").setup {
      ignored_buftypes = {
        "nofile",
        "quickfix",
        "prompt",
      },

      ignored_filetypes = { "NvimTree" },

      cursor_follows_swapped_bufs = true,
      kitty_kittens_path = "kittens",
    }
  end,
}
