local set_hl = vim.api.nvim_set_hl

set_hl(0, "ColorColumn", { bg = "#440011" })
-- set_hl(0, "@variable.builtin.python", { fg = "#b2b2b2" })
set_hl(0, "@parameter.python", { fg = "#5fafff" })
set_hl(0, "@type.builtin.python", { fg = "#ff5fff" })
set_hl(0, "@constant.builtin.python", { link = "Constant" })
set_hl(0, "QuickFixLine", { link = "WarningMsg" })

-- Setup jellybeans colors before jellybeans is loaded
vim.g.jellybeans_use_term_background_color = 1
vim.g.jellybeans_use_term_italics = 1
vim.cmd [[ let g:jellybeans_overrides = {
\  "background": { "guibg": "NONE" },
\  "Folded": { "guibg": "NONE" },
\  "LineNr": { "guibg": "NONE" },
\  "Normal": { "guibg": "NONE" },
\  "SignColumn": { "guibg": "NONE" },
\  "Special": {"guifg": "c9dd9a",},
\}
]]

return {
  {
    "nanotech/jellybeans.vim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("jellybeans")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        background = {
          dark = "wave",
          light = "lotus",
        },
        colors = {
          theme = { all = { ui = { bg_gutter = "none" }, }, },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            TelescopeBorder = { bg = "none" },
            -- ColorColumn = { bg = "#440011" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless

            --[[ LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim }, ]]

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            --[[ TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim }, ]]

          }
        end,
      })
      -- vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
