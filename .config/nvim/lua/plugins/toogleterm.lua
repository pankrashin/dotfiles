return {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<D-\\>",
      function()
        require("toggleterm").toggle()
      end,
      desc = "Toggle Terminal (Floating)",
    },
    -- Normal mode mappings
    {
      "<D-1>",
      "<Cmd>1ToggleTerm<CR>",
      desc = "Toggle Terminal 1",
      mode = "n",
    },
    {
      "<D-2>",
      "<Cmd>2ToggleTerm<CR>",
      desc = "Toggle Terminal 2",
      mode = "n",
    },
    {
      "<D-3>",
      "<Cmd>3ToggleTerm<CR>",
      desc = "Toggle Terminal 3",
      mode = "n",
    },
    -- Terminal mode mappings (these work from inside the terminal)
    {
      "<D-1>",
      "<Cmd>1ToggleTerm<CR>",
      desc = "Toggle Terminal 1",
      mode = "t",
    },
    {
      "<D-2>",
      "<Cmd>2ToggleTerm<CR>",
      desc = "Toggle Terminal 2",
      mode = "t",
    },
    {
      "<D-3>",
      "<Cmd>3ToggleTerm<CR>",
      desc = "Toggle Terminal 3",
      mode = "t",
    },
  },

  opts = {
    shell = "/opt/homebrew/bin/fish",
    open_mapping = [[<D-\>]],
    size = function(term)
      if term.direction == "float" then
        return 20
      end
    end,

    float_opts = {
      border = "curved",
      title_pos = "center",
      title = function(term)
        return "Terminal " .. term.id
      end,
      width = function()
        return math.floor(vim.o.columns * 0.8)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
      winblend = 0,
    },
    direction = "float",
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_mode = true,
    persist_size = true,
    -- on_create = function(term)
    --   vim.api.nvim_buf_set_name(term.bufnr, "Terminal #" .. term.id)
    -- end,
  },
}
