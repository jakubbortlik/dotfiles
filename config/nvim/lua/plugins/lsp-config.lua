local M = {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
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
        opts = { library = { plugins = { "nvim-dap-ui" }, types = true }, },
      },
      "hrsh7th/cmp-nvim-lsp", -- Add LSP completion capabilities
    },
    config = function()
      -- [[ Configure LSP ]]
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        -- More easily define mappings specific for LSP related items. Set the mode,
        -- buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        local telescope_builtin = require("telescope.builtin")

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("<leader>cf", vim.lsp.buf.format, "[C]ode action: [F]ormat current buffer")

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")
        nmap("gR", vim.lsp.buf.references, "Show [R]eferences in quickfix")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

        nmap("<leader>ss", telescope_builtin.lsp_document_symbols, "[s]earch document [s]ymbols")
        nmap("<leader>sW", telescope_builtin.lsp_dynamic_workspace_symbols, "[s]earch [W]orkspace symbols")

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

        -- Less used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
      end

      -- Enable the following language servers. They will automatically be installed.
      local servers = {
        pylsp = {}, -- run ":PylspInstall <plugin>" to install plugins
        lua_ls = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
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
      vim.diagnostic.config{ float={border=_border} }
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
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- linters
          null_ls.builtins.diagnostics.pydocstyle.with({
            extra_args = { "--ignore=" .. warnings_str },
          }),
          null_ls.builtins.diagnostics.shellcheck,                                               -- sh
          null_ls.builtins.diagnostics.vint,                                                     -- vimscript
          null_ls.builtins.diagnostics.vulture.with({ args = { "$FILENAME", "whitelist.py" } }), -- detect unused code in Python
          null_ls.builtins.diagnostics.buf,                                                      -- protobuf
          null_ls.builtins.diagnostics.commitlint,                                               -- conventional commits
          null_ls.builtins.diagnostics.yamllint,                                                 -- YAML
          -- formatters
          null_ls.builtins.formatting.buf,      -- Protobuf formatting
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.textlint, -- Mardown
        },
      }
    end,
  },
}

return M
