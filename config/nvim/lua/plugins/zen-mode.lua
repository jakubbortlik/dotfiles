M = {
  "folke/zen-mode.nvim",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>",              desc = "Toggle Zen Mode" },
    { "<leader>Z", "<cmd>ZenMode | set nodiff<cr>", desc = "Toggle Zen Mode and turn off diff" },
  },
  config = true,
}

return M
