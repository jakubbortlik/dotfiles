local M = {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        "williamboman/mason.nvim",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        config = true,
      },
      { "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls", "ruff_lsp", "pyright" },
          }
        end,
      },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      lsp.ruff_lsp.setup { capabilities = capabilities }

      lsp.pyright.setup { capabilities = capabilities }

      lsp.lua_ls.setup { capabilities = capabilities }

      lsp.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.stdpath "config" .. "/lua"] = true,
              },
            },
          },
        }
      }

    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.black,
          nls.builtins.formatting.stylua,
        },
      }
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    config = true,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
