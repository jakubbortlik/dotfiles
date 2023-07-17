-- Use the DAP and Neotest plugins to debug code
-- Primarily focused on configuring the debugger for Python

local python_path = function()
  -- TODO: find out if it's possible to get the VIRTUAL_ENV activated in the DAP REPL.
  -- Debugpy supports launching an application with a different interpreter then
  -- the one used to launch debugpy itself.
  -- The code below looks for a Python executable within the `VIRTUAL_ENV` environment.
  -- 
  -- return "/home/jakub/.cache/pypoetry/virtualenvs/phonexia-speech-api-ny0Relwj-py3.11/bin/python"
  local vdir = os.getenv("VIRTUAL_ENV")
  if vdir then
    return vdir .. "/bin/python"
  else
    return "/usr/bin/python3"
  end
end

local M = {

  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>" },
      { "<F7>" },
      { "<leader>bb" },
      { "<leader>bc" },
      { "<leader>bC" },
    },
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
      keymap("n", "<F6>", dap.terminate, { desc = "Dap terminate" })
      -- Toggle to see last session result to see session output in case of unhandled exception
      keymap("n", "<F7>", function() dapui.toggle({ reset = true }) end, { desc = "Dapui toggle" })

      local opts = { noremap = true, silent = true }
      local pbapi = require("persistent-breakpoints.api")
      -- Save breakpoints to file automatically.
      keymap(
        "n",
        "<leader>bb",
        pbapi.toggle_breakpoint,
        { unpack(opts), desc = "Dap toggle [b]reakpoint" }
      )
      keymap(
        "n",
        "<leader>bc",
        pbapi.set_conditional_breakpoint,
        { unpack(opts), desc = "Dap set [b]reakpoint [c]onditional" }
      )
      keymap(
        "n",
        "<leader>bC",
        pbapi.clear_all_breakpoints,
        { unpack(opts), desc = "Dap [b]reakpoints - [C]lear all" }
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

      require('dap-python').setup()
      local dap_python = require('dap-python')
      keymap("n", "<leader>dm", dap_python.test_method)
      keymap("n", "<leader>dc", dap_python.test_class)
      keymap("v", "<leader>ds", dap_python.debug_selection)

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

      vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "WinEnter"}, {
        group = id_dap,
        pattern = "dap-\\(frames\\|hover\\|preview\\|scopes\\)*",
        callback = function()
          vim.keymap.set("n", "q", "<cmd>quit<cr>", { desc = "Quit this window", buffer = true })
        end
      })

      -- In the elements, use mappings similar to PUDB
      vim.api.nvim_create_autocmd("WinEnter", {
        group = id_dap,
        pattern = "\\(DAP \\(Scopes\\|Breakpoints\\|Stacks\\|Watches\\)\\|\\[dap-repl\\]\\)",
        callback = function()
          local nmap = function(keys, func, desc)
            if desc then
              desc = "DAP: " .. desc
            end
            vim.keymap.set("n", keys, func, { desc = desc, buffer = true })
          end
          nmap("B", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Breakpoints')))<cr>", "[G]o to [B]reakpoints")
          nmap("V", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Scopes')))<cr>", "[G]o to [V]ariable scopes")
          nmap("W", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Watches')))<cr>", "[G]o to [W]atches")
          nmap("S", "<cmd>call win_gotoid(win_getid(bufwinnr('DAP Stacks')))<cr>", "[G]o to [S]tacks")
          nmap("!!", "<cmd>call win_gotoid(win_getid(bufwinnr('\\[dap-repl\\]')))<cr>", "[G]o to [R]EPL")

          -- Move cursor up and down in insert mode (useful in dap REPL)
          vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move cursor down / Select next command", remap = true })
          vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move cursor up / Select previous command", remap = true })

        end
      })
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- Install Python specific config
      require("dap-python").setup(python_path())
      require("dap-python").resolve_python = function()
        return python_path()
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
            dap = { justMyCode = true },
            python = python_path(),
          }),
        },
        quickfix = {
          enabled = true,
          open = false,
        },
      })
      local neotest = package.loaded.neotest
      local wk = require("which-key")
      -- Register normal mode keymaps
      wk.register({
        n = {
          name = "Neotest", -- optional group name
          d = { function() neotest.run.run({vim.fn.expand("%"), strategy = "dap" }) end, "Run [n]eotest for current file with [d]ap" },
          f = { function() neotest.run.run({vim.fn.expand("%")}) end, "Run [n]eotest for current [f]ile" },
          n = { neotest.run.run, "Run [n]eotest for [n]earest test" },
          l = { neotest.run.run_last, "Run [n]eotest for [l]ast position (same args and strategy)" },
          L = { function() neotest.run.run_last({strategy = "dap" }) end, "Run [n]eotest for [L]ast position (same args but with DAP)" },
          w = { function() neotest.watch.toggle(vim.fn.expand("%")) end, "Toggle [n]eotest [w]atching the current file" },
          W = { neotest.watch.toggle, "Toggle [n]eotest [W]atching the nearest test" },
          o = { function() neotest.output.open({ enter = false, autoclose = true }) end, "Open [n]eotest [o]utput" },
          O = { function() neotest.output_panel.open({ enter = false, autoclose = true }) end, "Open [n]eotest [O]utput panel" },
          s = { neotest.summary.toggle, "Toggle [n]eotest [s]ummary" },
        },
      }, { prefix = "<leader>" })
      vim.keymap.set( "n", "[n", function() neotest.jump.prev({ status = "failed" }) end, { desc = "Jump to previous failed test" })
      vim.keymap.set( "n", "]n", function() neotest.jump.next({ status = "failed" }) end, { desc = "Jump to next failed test" })
    end,
  },
}

return M
