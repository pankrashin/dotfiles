return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer" },
      }
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "SmiteshP/nvim-navic",
    },

    config = function()
      local cmp = require "cmp"
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      -- The setup for nvim-cmp.
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      }

      -- Get the capabilities from nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Get navic
      local navic = require "nvim-navic"

      -- Configure diagnostic display
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        signs = true,
        update_in_insert = true,
      })

      -- Create on_attach function for navic
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)

      -- rust_analyzer
      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
          },
        },
      })

      -- lua_ls
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- emmet_language_server
      vim.lsp.config("emmet_language_server", {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "html",
          "css",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "xml",
          "xsl",
          "pug",
          "haml",
          "php",
        },
        init_options = {
          showExpandedAbbreviation = "always",
          showAbbreviationSuggestions = true,
          showSuggestionsAsSnippets = true,
        },
      })
      vim.lsp.enable "emmet_language_server"

      -- Enable the configured LSP servers
      vim.lsp.enable "rust_analyzer"
      vim.lsp.enable "lua_ls"

      -- Add more LSP servers here as needed:
      -- vim.lsp.config("ts_ls", {
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })
      -- vim.lsp.enable("ts_ls")

      -- vim.lsp.config("pyright", {
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })
      -- vim.lsp.enable("pyright")
    end,
  },
}
