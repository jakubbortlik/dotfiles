local M = {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Navigation in a popup window using LSP
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      },
      -- Automatically install LSPs to stdpath for neovim
      {
        "williamboman/mason.nvim",
        keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
        config = function()
          require("mason").setup({
            ui = { border = "rounded" },
          })
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      {
        "folke/neodev.nvim",
        opts = { library = { plugins = { "nvim-dap-ui", "neotest" }, types = true }, },
      },
      "hrsh7th/cmp-nvim-lsp", -- Add LSP completion capabilities
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim", -- autoinstall non-LSP tools
        dependencies = {
          "williamboman/mason.nvim",
          "williamboman/mason-lspconfig.nvim",
        },
        config = function()
          require("mason-tool-installer").setup({
            ensure_installed = {
              "black",
              "buf",
              "commitlint",
              "debugpy",
              "shellcheck",
              "stylua",
              "textlint",
              "vint",
              "vulture",
              "yamllint",
            },
          })
        end,
      },
    },
    config = function()
      local navic = require("nvim-navic")
      -- [[ Configure LSP ]]
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
        -- More easily define mappings specific for LSP related items. Set the mode,
        -- buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        local imap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
        end

        local telescope_builtin = require("telescope.builtin")

        nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
        nmap("<leader>cf", vim.lsp.buf.format, "[c]ode action: [f]ormat current buffer")

        nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
        nmap("gD", "<cmd>tab split | lua vim.lsp.buf.definition()<cr>", "[g]o to [D]efinition in new tab")
        nmap("g<C-d>", telescope_builtin.lsp_definitions, "[g]oto [d]efinitions with telescope")
        nmap("gr", telescope_builtin.lsp_references, "[g]oto [r]eferences")
        nmap("gR", vim.lsp.buf.references, "Show [R]eferences in quickfix")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

        nmap("<leader>ss", telescope_builtin.lsp_document_symbols, "[s]earch document [s]ymbols")
        nmap(
          "<leader>sW",
          telescope_builtin.lsp_dynamic_workspace_symbols,
          "[s]earch [W]orkspace symbols"
        )

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        imap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Less used LSP functionality
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
      end

      -- Enable the following language servers. They will automatically be installed.
      local servers = {
        pylsp = {
          plugins = {
            rope_completion = {
              enabled = false
            },
            rope_autoimport = {
              enabled = true
            },
            mypy = {
              enabled = true,
              dmypy = true,
            },
          },
        }, -- run ":PylspInstall <plugin>" to install the following plugins:
        -- pylsp-mypy       -- type checking
        -- pylsp-rope       -- refactoring (import sort)
        -- pyls-memestra    -- deprecation warnings
        -- python-lsp-ruff  -- linting
        -- python-lsp-black -- autoformatting
        lua_ls = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              disable = { "missing-fields" },
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      -- Setup neovim lua configuration
      require("neodev").setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })

      -- Put nice borders around lsp-related floating windows
      local _border = "rounded"
      require('lspconfig.ui.windows').default_options = { border = _border }
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, { border = _border }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border = _border }
      )
      vim.diagnostic.config({ float = { border = _border } })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      local warnings = {
        -- More info at: http://www.pydocstyle.org/en/stable/error_codes.html
        "D100", -- Missing docs in public module
        "D101", -- Missing docs in public class
        "D102", -- Missing docs in public method
        "D103", -- Missing docs in public function
        -- "D104", -- Missing docs in public package
        "D105", -- Missing docs in magic method
        "D106", -- Missing docstring in public nested class
        "D107", -- Missing docstring in __init__
        "D203", -- 1 blank line required before class docstring
        "D213", -- Multi-line docstring summary should start at the second line
        "D400", -- First line should end with a period
        "D407", -- Missing dashed underline after section
        "D413", -- Missing blank line after last section
        "D415", -- First line should end with a period, question mark, or exclamation point
      }
      local warnings_str = table.concat(warnings, ",")
      -- Disable null_ls source for fugitive buffers
      local disable_for_fugitive = function(params)
        if string.find(params.bufname, "fugitive://") then
          return false
        else
          return true
        end
      end
      return {
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git"
        ),
        sources = {
          -- linters
          null_ls.builtins.diagnostics.pydocstyle.with({
            extra_args = { "--ignore=" .. warnings_str },
            runtime_condition = disable_for_fugitive,
          }),
          null_ls.builtins.diagnostics.shellcheck, -- sh
          null_ls.builtins.diagnostics.vint,       -- vimscript
          -- detect unused code in Python
          null_ls.builtins.diagnostics.vulture.with({
            args = { "$FILENAME", "whitelist.py" },
            runtime_condition = disable_for_fugitive,
          }),
          null_ls.builtins.diagnostics.buf,        -- protobuf
          null_ls.builtins.diagnostics.commitlint, -- conventional commits
          -- null_ls.builtins.diagnostics.markdownlint.with({ command = "/usr/lib/node_modules/node/bin/markdownlint" }),
          null_ls.builtins.diagnostics.yamllint,   -- YAML
          -- formatters
          null_ls.builtins.formatting.buf,         -- Protobuf formatting
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.textlint,    -- Mardown
        },
      }
    end,
  },
}

return M
