return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = true
    },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local on_attach = function(_, bufnr)
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions

      -- Create map function.
      local nmap = function(keys, func, desc)
        -- if desc then
        --   desc = "LSP: " .. desc
        -- end
        local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
        vim.keymap.set("n", keys, func, opts)
      end

      --local position_encoding = client.offset_encoding or "utf-16"

      -- set keybinds
      nmap("<leader>gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")

      -- go to declaration
      nmap("<leader>gD", vim.lsp.buf.declaration, "Go to declaration")

      -- show lsp definitions
      nmap("<leader>gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")

      -- show lsp implementations
      nmap("<leader>gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")

      -- show lsp type definitions
      nmap("<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")

      -- see available code actions, in visual mode will apply to selection
      nmap("<leader>gca", vim.lsp.buf.code_action, "See available code actions")

      -- smart rename
      nmap("<leader>gr", vim.lsp.buf.rename, "Smart rename")

      -- show documentation for what is under cursor
      nmap("<leader>gk", vim.lsp.buf.hover, "Show documentation for what is under cursor")

      -- mapping to restart lsp if necessary
      nmap("<leader>rs", ":LspRestart<CR>", "Restart LSP")

      -- diagnostics block
      nmap("<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>",
          "Open float diagnostic window")
      nmap("<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>",
          "Goto previous diagnostic message")
      nmap("<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>",
          "Goto previous diagnostic message")
      nmap("<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>",
          "Open diagnostic local list")
      nmap("<leader>dt", "<cmd>Telescope diagnostics<CR>",
           "Open telescope diagnostic")
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.lsp.config.pyright = {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "pyright" },
      filetypes = { "py" },
    }

    vim.lsp.config.clangd = {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--clang-tidy",
        "--background-index",
        "--offset-encoding=utf-8",
      },
      root_markers = { ".clangd", "compile_commands.json" },
      filetypes = { "c", "cpp" },
    }

    vim.lsp.config["bashls"] = {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh" },
      single_file_support = true,
      settings = {
        bashIde = {
          explainshellEndpoint = "https://explainshell.com",
          shellcheckPath = "shellcheck",
          globPattern = "**/*@(.sh|.inc|.bash|.command)",
        },
      },
    }

    vim.lsp.config["lua_ls"] = {
      on_attach = on_attach,
      capabilities = capabilities,
      -- Command and arguments to start the server.
      cmd = { "lua-language-server" },
      -- Filetypes to automatically attach to.
      filetypes = { "lua" },
      -- Sets the "workspace" to the directory where any of these files is found.
      -- Files that share a root directory will reuse the LSP server connection.
      -- Nested lists indicate equal priority, see |vim.lsp.Config|.
      root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
      -- Specific settings to send to the server. The schema is server-defined.
      -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
          codeLens = {
            enable = true,
          },
          completion = {
            callSnippet = "Replace",
          },
          doc = {
            privateName = { "^_" },
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
        },
      },
    }
  end
}
