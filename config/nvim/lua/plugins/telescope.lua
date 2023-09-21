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

      nmap("<leader>sd", builtin.diagnostics, "[s]earch [d]iagnostics")
      nmap("<leader>sf", builtin.find_files, "[s]earch [f]iles")
      nmap("<leader>sG", builtin.git_files, "[s]earch [G]it files")
      nmap("<leader>sg", builtin.live_grep, "[s]earch by [g]rep")
      nmap("<leader>sh", builtin.help_tags, "[s]earch [h]elp")
      nmap("<leader>sr", builtin.resume, "[s]earch - [r]esume")
      nmap("<leader>sw", builtin.grep_string, "[s]earch current [w]ord")
      nmap("<leader>sz", function() builtin.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' }) end, "[s]earch by grep fu[z]zily")
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
