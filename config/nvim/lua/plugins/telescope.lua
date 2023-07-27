local M = {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nyarthan/telescope-code-actions.nvim",
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          dynamic_preview_title = true,
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          },
        },
      })
      pcall(telescope.load_extension, "fzf") -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, "code_actions") -- Enable telescope code actions, if installed
      pcall(telescope.load_extension, "ui-select") -- Enable telescope code actions, if installed
      local builtin = require("telescope.builtin")

      local nmap = function(keys, func, desc)
        if desc then
          desc = "Telescope: " .. desc
        end
        vim.keymap.set("n", keys, func, { desc = desc })
      end

      nmap("<leader>?", builtin.oldfiles, "[?] Find recently opened files")
      nmap("<leader><space>", builtin.buffers, "[ ] Find existing buffers")
      nmap("<leader>/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, "[/] Fuzzily search in current buffer")

      nmap("<leader>gf", builtin.git_files, "Search [G]it [F]iles")
      nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles")
      nmap("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
      nmap("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
      nmap("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
      nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
}

return M
