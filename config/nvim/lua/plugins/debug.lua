-- Use the DAP and Neotest plugins to debug code
-- Primarily focused on configuring the debugger for Python

local M = {

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",
      "LiadOz/nvim-dap-repl-highlights",

      -- Show variable values as virtual text
      "theHamsta/nvim-dap-virtual-text",
      -- Work with breakpoints
      {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
          require("persistent-breakpoints").setup({ load_breakpoints_event = { "BufReadPost" } })
        end,
      },
      "ofirgall/goto-breakpoints.nvim",
      -- Automate debug adapter installation
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      -- Add debuggers here:
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,
        -- TODO: Provide additional configuration to the handlers, see mason-nvim-dap
        -- README for more information.
        handlers = {},
        ensure_installed = {
          "python",
        },
      })
      require("nvim-dap-virtual-text").setup()

      local keymap = vim.keymap.set

      -- Basic debugging keymaps, feel free to change to your liking!
      keymap("n", "<F1>", dap.step_into, { desc = "Dap step into" })
      keymap("n", "<F2>", dap.step_over, { desc = "Dap step over" })
      keymap("n", "<F3>", dap.step_out, { desc = "Dap step out" })
      keymap("n", "<F4>", dap.step_back, { desc = "Dap step out" })
      keymap("n", "<F5>", dap.continue, { desc = "Dap continue" })
      keymap("n", "<F6>", dap.terminate, { desc = "Dap continue" })
      -- Toggle to see last session result to see session output in case of unhandled exception
      keymap("n", "<F7>", function() dapui.toggle({ reset = true }) end, { desc = "Dapui toggle" })

      local opts = { noremap = true, silent = true }
      local persistent_breakpoints_api = require("persistent-breakpoints.api")
      -- Save breakpoints to file automatically.
      keymap(
        "n",
        "<leader>b",
        persistent_breakpoints_api.toggle_breakpoint,
        { unpack(opts), desc = "Dap toggle breakpoint" }
      )
      keymap(
        "n",
        "<leader>cb",
        persistent_breakpoints_api.set_conditional_breakpoint,
        { unpack(opts), desc = "Dap set conditional breakpoint" }
      )
      keymap(
        "n",
        "<leader>cc",
        persistent_breakpoints_api.clear_all_breakpoints,
        { unpack(opts), desc = "Dap clear all breakpoints" }
      )

      keymap('n', ']b', require('goto-breakpoints').next, { desc = "Go to next [B]reakpoint" })
      keymap('n', '[b', require('goto-breakpoints').prev, { desc = "Go to previous [B]reakpoint" })
      keymap('n', ']t', require('goto-breakpoints').stopped, { desc = "Go to breakpoin[T] at the current stopped line" })
      keymap('n', '[t', require('goto-breakpoints').stopped, { desc = "Go to breakpoin[T] at the current stopped line" })

      local widgets = require("dap.ui.widgets")

      keymap({ "n", "v" }, "<Leader>dh", function() widgets.hover() end, { desc = "[D]ap widgets [H]over" })
      keymap({ "n", "v" }, "<Leader>dp", function() widgets.preview() end, { desc = "[D]ap widgets [P]review" })
      keymap("n", "<Leader>df", function() widgets.centered_float(widgets.frames) end, { desc = "[D]ap float widget [F]rames" })
      keymap("n", "<Leader>dv", function() widgets.centered_float(widgets.scopes) end, { desc = "[D]ap float widget [V]ariable scopes" })

      -- Dap UI setup
      dapui.setup({
        -- Icons for trees
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          -- Icons for the REPL
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "",
          },
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 }
            },
            position = "left",
            size = 40
          },
          {
            elements = {
              { id = "repl", size = 0.90 }
            },
            position = "bottom",
            size = 10
          }
        },
      })

      -- Navigate between dapui elements
      -- TODO: Get rid of the repeating `win_gotoid` and `require` calls
      keymap({"n", "i"}, "<C-q>b", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Breakpoints')))<cr>", { desc = "[G]o to [B]reakpoints" })
      keymap({"n", "i"}, "<C-q>v", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Scopes')))<cr>", { desc = "[G]o to [V]ariable scopes" })
      keymap({"n", "i"}, "<C-q>w", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Watches')))<cr>", { desc = "[G]o to [W]atches" })
      keymap({"n", "i"}, "<C-q>r", "<cmd>call win_gotoid(win_getid(bufwinnr('\\[dap-repl\\]')))<cr>", { desc = "[G]o to [R]EPL" })
      keymap({"n", "i"}, "<C-q>s", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Stacks')))<cr>", { desc = "[G]o to [S]tacks" })

      keymap({"n"}, "[n", [[<cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>]], { desc = "Jump to previous failed test" })
      keymap({"n"}, "]n", [[<cmd>lua require("neotest").jump.next({ status = "failed" })<CR>]], { desc = "Jump to next failed test" })

      keymap({"n"}, "<leader>nd", [[<cmd> lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"})<cr>]], { desc = "Run [N]eotest for current file with [D]AP" })
      keymap({"n"}, "<leader>nf", [[<cmd> lua require("neotest").run.run({vim.fn.expand("%")})<cr>]], { desc = "Run [N]eotest for current [F]ile" })
      keymap({"n"}, "<leader>nn", [[<cmd> lua require("neotest").run.run()<cr>]], { desc = "Run [N]eotest for [N]earest test" })
      keymap({"n"}, "<leader>nl", [[<cmd> lua require("neotest").run.run_last()<cdr>]], { desc = "Run [N]eotest for the [l]ast position with the same args and strategy" })
      keymap({"n"}, "<leader>nL", [[<cmd> lua require("neotest").run.run_last({strategy = "dap"})<cdr>]], { desc = "Run [N]eotest for the [L]ast position with the same args but with DAP" })

      keymap({"n"}, "<leader>nw", [[<cmd> lua require("neotest").watch.toggle(vim.fn.expand("%"))<cr>]], { desc = "Toggle [W]atching the current file with [N]eotest" })
      keymap({"n"}, "<leader>nW", [[<cmd> lua require("neotest").watch.toggle()<cr>]], { desc = "Toggle [W]atching the nearest test with [N]eotest" })

      keymap({"n"}, "<leader>no", [[<cmd> lua require("neotest").output.open({ enter = true })<cr>]], { desc = "Open [N]eotest [O]utput" })
      keymap({"n"}, "<leader>ns", [[<cmd> lua require("neotest").summary.toggle()<cr>]], { desc = "Toggle [N]eotest [S]ummary" })

      -- Debugger autocommands
      local id_dap = vim.api.nvim_create_augroup("DAP", {
        clear = false
      })
      vim.api.nvim_create_autocmd("WinEnter", {
        group = id_dap,
        pattern = "\\[dap-repl\\]",
        callback = vim.schedule_wrap(function(args)
          vim.api.nvim_set_current_win(vim.fn.bufwinid(args.buf))
        end)
      })
      -- In the elements, use mappings similar to PUDB
      vim.api.nvim_create_autocmd("WinEnter", {
        group = id_dap,
        pattern = "\\(DAP \\(Scopes\\|Breakpoints\\|Stacks\\|Watches\\)\\|\\[dap-repl\\]\\)",
        callback = function()
          local nmap = function(keys, func, desc)
            if desc then
              desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { desc = desc, buffer = true })
          end
          nmap("B", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Breakpoints')))<cr>", "[G]o to [B]reakpoints")
          nmap("V", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Scopes')))<cr>", "[G]o to [V]ariable scopes")
          nmap("W", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Watches')))<cr>", "[G]o to [W]atches")
          nmap("S", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Stacks')))<cr>", "[G]o to [S]tacks")
          nmap("!!", "<cmd>call win_gotoid(win_getid(bufwinnr('\\[dap-repl\\]')))<cr>", "[G]o to [R]EPL")
        end
      })

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      local pythonPath = function()
        -- TODO: find out if it's possible to get the VIRTUAL_ENV activated in the REPL
        -- Debugpy supports launching an application with a different interpreter then
        -- the one used to launch debugpy itself.
        -- The code below looks for a Python executable within the `VIRTUAL_ENV`
        -- environment.
        local vdir = os.getenv("VIRTUAL_ENV")
        if vdir then
          return vdir .. "/bin/python"
        else
          return "/usr/bin/python3"
        end
      end
      -- Install Python specific config
      require("dap-python").setup(pythonPath())
      require("dap-python").resolve_python = function()
        -- return "/home/jakub/.cache/pypoetry/virtualenvs/phonexia-speech-api-ny0Relwj-py3.11/bin/python"
        return pythonPath()
      end
    end,
  },

  -- Setup Neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
        },
        quickfix = {
          enabled = true,
          open = false,
        },
      })
    end,
  },
}

return M

-- vim: ts=2 sts=2 sw=2 et:
