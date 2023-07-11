local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    })
  end,
  keys = {
    {
      "<C-t><C-e>",
      '<cmd>execute v:count . "ToggleTerm"<cr>',
      mode = { "n" },
      desc = "Toggle horizontal terminal"
    },
    {
      "<C-t><C-a>",
      '<cmd>execute v:count . "ToggleTerm direction=vertical"<cr>',
      mode = { "n" },
      desc = "Toggle vertical terminal",
    },
    {
      "<C-t>",
      "<cmd>ToggleTerm<cr>",
      mode = { "t" },
      desc = "Close Terminal",
    },
  },
}

return M
