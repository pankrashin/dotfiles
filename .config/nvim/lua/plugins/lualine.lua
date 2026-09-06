return {
  "nvim-lualine/lualine.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    {
      "linrongbin16/lsp-progress.nvim",
      opts = {
        format = function(client_messages)
          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients { bufnr = bufnr }

          if #client_messages > 0 then
            return table.concat(client_messages, " ")
          elseif next(clients) ~= nil then
            local client_names = {}
            for _, client in pairs(clients) do
              table.insert(client_names, client.name)
            end
            return "󰩦 " .. table.concat(client_names, ", ")
          end
          return "󰩦 "
        end,
      },
    },
  },

  event = "BufReadPost", -- Changed from VeryLazy to ensure earlier loading

  config = function()
    -- local cyberdream_colors = {
    --   bg = "#16181a",
    --   bg_alt = "#1e2124",
    --   bg_highlight = "#3c4048",
    --   fg = "#ffffff",
    --   grey = "#7b8496",
    --   blue = "#5ea1ff",
    --   green = "#5eff6c",
    --   cyan = "#5ef1ff",
    --   red = "#ff6e5e",
    --   yellow = "#f1ff5e",
    --   magenta = "#ff5ef1",
    --   pink = "#ff5ea0",
    --   orange = "#ffbd5e",
    --   purple = "#bd5eff",
    -- }

    local cyberdream_colors = {
      bg = "#ffffff",
      bg_alt = "#f5f5f5",
      bg_highlight = "#acacac",

      fg = "#16181a",
      grey = "#acacac",

      red = "#d11500",
      green = "#008b0c",
      yellow = "#997b00",
      blue = "#0057d1",
      magenta = "#a018ff",
      cyan = "#008c99",

      orange = "#d17c00",

      -- aliases for existing code
      purple = "#a018ff",
      pink = "#a018ff",
    }

    local function treesitter_status()
      local bufnr = vim.api.nvim_get_current_buf()
      local ts_highlighter = require "vim.treesitter.highlighter"

      if ts_highlighter.active[bufnr] then
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if ok and parser then
          local lang = parser:lang()
          return "󰹩 " .. lang
        end
      end

      return "󰹩 "
    end

    local function treesitter_color()
      local ts_highlighter = require "vim.treesitter.highlighter"
      if ts_highlighter.active[vim.api.nvim_get_current_buf()] then
        return { fg = cyberdream_colors.green }
      end
      return { fg = cyberdream_colors.red }
    end

    local function formatter()
      local conform = require "conform"
      local formatters = conform.list_formatters_to_run(0)

      local formatter_names = {}
      for _, formatter in ipairs(formatters) do
        table.insert(formatter_names, formatter.name)
      end

      return " " .. table.concat(formatter_names, ", ")
    end

    local function formatter_color()
      local ok, conform = pcall(require, "conform")
      if not ok then
        return { fg = cyberdream_colors.red }
      end

      local formatters = conform.list_formatters_to_run(0)
      if #formatters == 0 then
        return { fg = cyberdream_colors.red }
      else
        return { fg = cyberdream_colors.pink }
      end
    end

    local function linter()
      local ok, lint = pcall(require, "lint")
      if not ok then
        return ""
      end

      local filetype = vim.bo.filetype
      local linters = lint.linters_by_ft[filetype]

      if not linters or #linters == 0 then
        return "󱉶 "
      end

      return "󱉶 " .. table.concat(linters, ", ")
    end

    local function linter_color()
      local ok, lint = pcall(require, "lint")
      if not ok then
        return { fg = cyberdream_colors.red }
      end

      local filetype = vim.bo.filetype
      local linters = lint.linters_by_ft[filetype]

      if not linters or #linters == 0 then
        return { fg = cyberdream_colors.red }
      else
        return { fg = cyberdream_colors.yellow }
      end
    end

    local cyberdream_theme = {
      normal = {
        a = { fg = cyberdream_colors.blue, bg = cyberdream_colors.bg, gui = "bold" },
        b = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg },
        c = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg },
      },
      insert = {
        a = { fg = cyberdream_colors.green, bg = cyberdream_colors.bg, gui = "bold" },
        b = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg },
        c = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg },
      },
      visual = {
        a = { fg = cyberdream_colors.magenta, bg = cyberdream_colors.bg, gui = "bold" },
        b = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg },
        c = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg },
      },
      replace = {
        a = { fg = cyberdream_colors.red, bg = cyberdream_colors.bg_alt, gui = "bold" },
        b = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg_alt },
        c = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg_alt },
      },
      command = {
        a = { fg = cyberdream_colors.yellow, bg = cyberdream_colors.bg_alt, gui = "bold" },
        b = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg_alt },
        c = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg_alt },
      },
      inactive = {
        a = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg_alt },
        b = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg_alt },
        c = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg_alt },
      },
    }

    require("lualine").setup {
      options = {
        theme = cyberdream_theme,
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            color = { fg = cyberdream_colors.red },
          },
          {
            "diff",
            symbols = { added = "+", modified = "~", removed = "-" },
            diff_color = {
              added = { fg = cyberdream_colors.green },
              modified = { fg = cyberdream_colors.orange },
              removed = { fg = cyberdream_colors.red },
            },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "󰅙 ", warn = " ", info = " ", hint = " " },
            diagnostics_color = {
              error = { fg = cyberdream_colors.red },
              warn = { fg = cyberdream_colors.yellow },
              info = { fg = cyberdream_colors.cyan },
              hint = { fg = cyberdream_colors.cyan },
            },
          },
        },

        lualine_c = {
          {
            "filename",
            path = 1, -- Show only the file name
            color = { fg = cyberdream_colors.fg },
          },
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return require("nvim-navic").is_available()
            end,
            color = { fg = cyberdream_colors.fg },
          },
        },

        lualine_x = {
          {
            -- Component to display the active foreground process in toggleterm
            function()
              local function get_foreground_process(shell_pid)
                -- 1. Get the controlling TTY.
                local f_tty = io.popen("ps -o tty= -p " .. shell_pid)
                local tty_name
                if f_tty then
                  tty_name = f_tty:read("*a"):gsub("[%s\n\r]", "")
                  f_tty:close()
                end

                local f_shell = io.popen("ps -o comm= -p " .. shell_pid)
                local shell_name = "shell"
                if f_shell then
                  shell_name = f_shell:read("*a"):gsub("[\n\r]", ""):match "([^/]+)$"
                  f_shell:close()
                end

                if not tty_name or tty_name == "" or tty_name == "?" then
                  return shell_name
                end

                -- 2. Ask `ps` for all processes (PID and ARGS) on that TTY.
                -- Changed 'comm' to 'args' to get full command line
                local f_list = io.popen("ps -o pid,args -t " .. tty_name)
                if not f_list then
                  return shell_name
                end

                local ps_output = f_list:read "*a"
                f_list:close()

                local max_pid = -1
                local cmd_for_max_pid = shell_name

                -- 3. Find process with highest PID
                for line in ps_output:gmatch "[^\n]+" do
                  -- Parse PID and the rest of the line (args)
                  local pid_str, args = line:match "^%s*(%d+)%s+(.*)$"
                  if pid_str then
                    local pid = tonumber(pid_str)
                    if pid and pid > max_pid then
                      max_pid = pid
                      cmd_for_max_pid = args
                    end
                  end
                end

                -- 4. Smart Formatter to clean up the command
                -- This separates "python script.py" -> "script.py"
                -- and "docker stats" -> "docker stats"
                local function format_cmd(cmd)
                  if not cmd then
                    return shell_name
                  end

                  -- Split command into parts
                  local parts = vim.split(cmd, " ", { trimempty = true })
                  local raw_exe = parts[1]
                  local exe_name = vim.fn.fnamemodify(raw_exe, ":t")

                  -- List of interpreters/wrappers to ignore
                  local interpreters =
                    { "python", "python3", "Python", "node", "npm", "ruby", "bash", "sh", "zsh", "sudo" }

                  local is_interpreter = false
                  for _, interp in ipairs(interpreters) do
                    if exe_name:match("^" .. interp) then
                      is_interpreter = true
                      break
                    end
                  end

                  -- If it's an interpreter, look for the actual script file
                  if is_interpreter then
                    for i = 2, #parts do
                      -- Skip flags (words starting with -)
                      if not parts[i]:match "^%-" then
                        return vim.fn.fnamemodify(parts[i], ":t")
                      end
                    end
                  end

                  -- Logic for tools with subcommands (like docker, git, cargo)
                  local tools_with_subcommands = { "docker", "git", "kubectl", "go", "cargo", "npm" }
                  for _, tool in ipairs(tools_with_subcommands) do
                    if exe_name == tool and parts[2] and not parts[2]:match "^%-" then
                      return tool .. " " .. parts[2]
                    end
                  end

                  -- Fallback: return just the executable name
                  return exe_name
                end

                return format_cmd(cmd_for_max_pid)
              end

              local ok, toggleterm = pcall(require, "toggleterm.terminal")
              if not ok then
                return ""
              end

              local terms = toggleterm.get_all()
              if #terms == 0 then
                return ""
              end

              local term_info = {}
              for _, term in ipairs(terms) do
                if term.job_id then
                  local pid = vim.fn.jobpid(term.job_id)
                  if pid and pid > 0 then
                    local process_name = get_foreground_process(pid)
                    local icon = term:is_focused() and " " or " "
                    table.insert(term_info, term.id .. " " .. icon .. process_name)
                  end
                end
              end

              if #term_info == 0 then
                return ""
              end
              return table.concat(term_info, " | ")
            end,
            cond = function()
              local ok, toggleterm = pcall(require, "toggleterm.terminal")
              return ok and #toggleterm.get_all() > 0
            end,
            color = { fg = cyberdream_colors.orange },
          },
          {
            treesitter_status,
            color = treesitter_color,
          },
          {
            function()
              -- invoke `progress` here.
              return require("lsp-progress").progress()
            end,
            color = function()
              local bufnr = vim.api.nvim_get_current_buf()
              local clients = vim.lsp.get_clients { bufnr = bufnr }

              if next(clients) ~= nil then
                return { fg = cyberdream_colors.purple }
              else
                return { fg = cyberdream_colors.red }
              end
            end,
          },
          {
            formatter,
            color = formatter_color,
          },

          { linter, color = linter_color },
          { "filetype", color = { fg = cyberdream_colors.fg } },
        },
        lualine_y = {
          {
            "progress",
            color = { fg = cyberdream_colors.cyan },
          },
        },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree" },
    }
  end,
}
