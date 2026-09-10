vim.opt.title = true

function GetCurrentIconFile()
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return ""
  end
  local filename = vim.fn.expand "%:t"
  local ext = vim.fn.expand "%:e"
  local icon = devicons.get_icon(filename, ext, { default = true })
  return icon or ""
end

function GetTabTitle()
  local bufname = vim.fn.expand "%"
  local filetype = vim.bo.filetype

  -- Check if current buffer is nvim-tree
  if filetype == "NvimTree" or bufname:match "NvimTree" then
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return " " .. cwd_name
  end

  -- Check if current buffer is toggleterm
  if filetype == "toggleterm" then
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    local term_id = vim.b.toggle_number
    if term_id then
      return cwd_name .. "  Terminal " .. term_id
    end
    return cwd_name .. "  Terminal"
  end

  -- Default: show parent folder, icon, and filename
  local parent = vim.fn.fnamemodify(vim.fn.expand "%:p:h", ":t")
  local icon = GetCurrentIconFile()
  local filename = vim.fn.expand "%:t"
  return parent .. " " .. icon .. " " .. filename
end

vim.o.titlestring = "%{%v:lua.GetTabTitle()%}"