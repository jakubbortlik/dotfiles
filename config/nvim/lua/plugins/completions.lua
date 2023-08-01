local M = {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  dependencies = {
    "hrsh7th/cmp-buffer",                 -- nvim-cmp source for buffer words
    "petertriho/cmp-git",                 -- nvim-cmp source for git
    "hrsh7th/cmp-nvim-lsp",               -- Add LSP completion capabilities
    "hrsh7th/cmp-nvim-lsp-signature-help",  -- nvim-cmp source for function signatures
    "hrsh7th/cmp-path",                   -- nvim-cmp source for filesystem paths
    "ray-x/cmp-treesitter",               -- nvim-cmp source for treesitter nodes
    "rcarriga/cmp-dap",                   -- completion in DAP
    "davidsierradz/cmp-conventionalcommits", -- nvim-cmp source for Conventional Commits

    "lukas-reineke/cmp-under-comparator", -- better sorting for magic methods
    "onsails/lspkind.nvim",               -- Add vscode-like pictograms to LSP

    -- Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets", -- A number of user-friendly snippets
  },

  -- largely inspired by:
  -- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    local cmp = require("cmp")
    local types = require('cmp.types')
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")
    local select_opts = { behaviour = types.cmp.SelectBehavior.Select }

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
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping.confirm({ select = true }),

        ['<C-f>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {'i', 's'}),

        ['<C-b>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'}),

        ['<Tab>'] = cmp.mapping(function(fallback)
          local col = vim.fn.col('.') - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
        end, {'i', 's'}),

      }),
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None", }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None", }),
      },
      sources = {
        { name = "luasnip",   keyword_length = 2 },
        { name = "nvim_lsp",  keyword_length = 1 },
        { name = "nvim_lsp_signature_help",  keyword_length = 1 },
        { name = "conventionalcommits" },
        { name = "buffer",    keyword_length = 3 },
        { name = "git" },
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
      enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
      end,
      experimental = {
        ghost_text = true,
      },
    })
    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
        { name = "buffer" },
      },
    })
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you have installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = "buffer" },
      })
    })
  end,
}

return M
