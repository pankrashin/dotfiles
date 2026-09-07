vim.opt.title = true

function GetCurrentIconFile()
  local filename = vim.fn.expand "%:t"
  local icon = require("nvim-web-devicons").get_icon(filename)
  return icon or ""
end

function GetTabTitle()
  local bufname = vim.fn.expand "%"
  local filetype = vim.bo.filetype

  -- Check if current buffer is nvim-tree
  if filetype == "NvimTree" or bufname:match "NvimTree" then
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return " " .. cwd_name
  end

  -- Check if current buffer is toggleterm
  if filetype == "toggleterm" then
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    -- Access the buffer-local variable for the terminal ID
    local term_id = vim.b.toggle_number
    return cwd_name .. "  Terminal " .. term_id
  end

  -- Default: show parent folder, icon, and filename
  local parent = vim.fn.fnamemodify(vim.fn.expand "%:p:h", ":t")
  local icon = GetCurrentIconFile()
  local filename = vim.fn.expand "%:t"

  return parent .. " " .. icon .. " " .. filename
end

vim.o.titlestring = "%{%v:lua.GetTabTitle()%}"
