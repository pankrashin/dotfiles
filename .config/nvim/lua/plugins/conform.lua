return {
  "stevearc/conform.nvim",

  config = function()
    require("conform").setup {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        rust = { "rustfmt" },

        lua = { "stylua" },
        python = { "isort", "black" },

        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },

        php = { "php_cs_fixer", "pint" },

        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },

        dockerfile = { "dockerfmt" },

        markdown = { "prettierd", "prettier", stop_after_first = true },

        svg = { "xmlformat" },
      },
    }
  end,
}
