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
    "ray-x/cmp-treesitter", -- nvim-cmp source for treesitter nodes
    "rcarriga/cmp-dap",     -- completion in DAP
    -- "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API

    "lukas-reineke/cmp-under-comparator", -- better sorting for magic methods
    "onsails/lspkind.nvim", -- Add vscode-like pictograms to LSP

    -- Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets", -- A number of user-friendly snippets
  },

  config = function()
    local lspkind = require("lspkind")
    local cmp = require("cmp")
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          symbol_map = {
            Comment = "#",
            Error = "⚠",
            String = '"',
          },
          mode = "text",
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            path = "[Path]",
            treesitter = "[TS]",
            git = "[Git]",
          }),
        })
      },
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
      window = {
        completion = cmp.config.window.bordered({winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",}),
        documentation = cmp.config.window.bordered({winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",}),
      },
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "treesitter" },
        { name = "git" },
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
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
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
          { name = "buffer" },
        })
    })
    cmp.setup.cmdline({ "/", "?" }, {
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
