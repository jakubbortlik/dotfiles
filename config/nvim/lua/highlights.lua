local set_hl = vim.api.nvim_set_hl

set_hl(0, "ColorColumn", {bg = "#440011"})
set_hl(0, "@variable.builtin.python", { fg = "#b2b2b2" })
set_hl(0, "@parameter.python", { fg = "#5fafff" })
set_hl(0, "@type.builtin.python", { fg = "#ff5fff" })
set_hl(0, "@constant.builtin.python", { link = "Constant" })
set_hl(0, "QuickFixLine", { link = "WarningMsg" })

-- vim: ts=2 sts=2 sw=2 et
