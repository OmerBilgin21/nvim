return {
  {
    "stevearc/conform.nvim",
    opts = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = {
            "eslint_d",
            "prettier",
            stop_after_first = true,
          },
          javascriptreact = {
            "eslint_d",
            "prettier",
            stop_after_first = true,
          },
          typescript = {
            "eslint_d",
            "prettier",
            stop_after_first = true,
          },
          typescriptreact = {
            "eslint_d",
            "prettier",
            stop_after_first = true,
          },
          go = { "gofmt" },
          json = { "jq" },
        },
        default_format_opts = {
          lsp_format = "prefer",
        },
        notify_on_error = true,
        notify_no_formatters = true,
        log_level = vim.log.levels.ERROR,
        format_on_save = {
          timeout_ms = 5000,
          lsp_format = "fallback",
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })

      vim.keymap.set("n", "<leader>,", function()
        require("conform").format()
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ts_config = require("nvim-treesitter.configs")
      ts_config.setup({
        sync_install = false,
        ignore_install = {},
        auto_install = false,
        modules = {},
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "lua",
          "javascript",
          'typescript',
          "python",
          "jsonc",
          "markdown",
          "markdown_inline",
          "vim",
          "prisma" },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    lazy = false,
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        gopls = {},
        ts_ls = {},
        pyright = {},
        eslint = {
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      if is_react() then
        opts["servers"].tailwindcss = {}
        opts["servers"].cssls = {}
      end

      for server, config in pairs(opts.servers) do
        -- config.server_capabilities = capabilities
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
