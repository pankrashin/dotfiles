return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- split a name into number / text tokens
    local function tokens(s)
      local t, i, n = {}, 1, #s
      while i <= n do
        local c = s:sub(i, i)
        if c:match("%d") then
          local j = i
          while j <= n and s:sub(j, j):match("%d") do j = j + 1 end
          t[#t + 1] = { num = tonumber(s:sub(i, j - 1)) }
          i = j
        else
          local j = i
          while j <= n and not s:sub(j, j):match("%d") do j = j + 1 end
          t[#t + 1] = { str = s:sub(i, j - 1):lower() }
          i = j
        end
      end
      return t
    end

    local function natural_cmp(a, b)
      local ta, tb = tokens(a), tokens(b)
      for k = 1, math.min(#ta, #tb) do
        local x, y = ta[k], tb[k]
        if x.num and y.num then
          if x.num ~= y.num then return x.num < y.num end
        elseif x.str and y.str then
          if x.str ~= y.str then return x.str < y.str end
        else
          return x.num ~= nil          -- numbers before text at a tie position
        end
      end
      return #ta < #tb
    end

    require("nvim-tree").setup {
      sort = {
        sorter = function(nodes)
          table.sort(nodes, function(a, b)
            local a_dir = a.type == "directory"
            local b_dir = b.type == "directory"
            if a_dir ~= b_dir then return a_dir end   -- folders first
            return natural_cmp(a.name, b.name)
          end)
        end,
      },
      renderer = {
        root_folder_label = ":t",
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { ".DS_Store" },
      },
      sync_root_with_cwd = false,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
    }
  end,
}
