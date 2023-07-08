local M = {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  dependencies = {
    "hrsh7th/cmp-buffer",   -- nvim-cmp source for buffer words
    "hrsh7th/cmp-cmdline",  -- nvim-cmp source for vim's cmdline
    "hrsh7th/cmp-nvim-lsp", -- Add LSP completion capabilities
    "hrsh7th/cmp-path",     -- nvim-cmp source for filesystem paths
    "rcarriga/cmp-dap",     -- completion in DAP
    -- "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API

    -- Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets", -- A number of user-friendly snippets
  },

  config = function()
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-m>"] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },
    })
    cmp.setup({
      enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
      end
    })
    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" }
          }
        }
      })
    })
  end,
}
return M

-- vim: ts=2 sts=2 sw=2 et
