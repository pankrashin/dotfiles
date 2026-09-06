return {
  "mfussenegger/nvim-lint",

  config = function()
    local linters = require "lint"

    linters.linters_by_ft = {
      dockerfile = { "hadolint" },
      php = { "phpstan" },
    }

    local lint_is_visible = false

    vim.keymap.set("n", "<D-l>", function()
      lint_is_visible = not lint_is_visible

      if lint_is_visible then
        linters.try_lint()
      else
        local filetype = vim.bo.filetype
        local active_linters = linters.linters_by_ft[filetype]

        if not active_linters then
          lint_is_visible = false
          vim.notify("No linters configured for this filetype", vim.log.levels.WARN)
          return
        end

        for _, linter_name in ipairs(active_linters) do
          local ns_id = vim.api.nvim_create_namespace(linter_name)
          vim.diagnostic.set(ns_id, 0, {}, {})
        end
      end
    end, { desc = "[L]int: Toggle diagnostics" })
  end,
}
