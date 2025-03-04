return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local rep = require("luasnip.extras").rep

      ls.add_snippets("typescriptreact", {
        s("tsrafce", {
          t({ "import React from 'react';", "" }),
          t("type Props = {};"),
          t({ "", "const " }),
          i(1, "ComponentName"),
          t({
            ": React.FC<Props> = () => {",
            "  return (",
            "    <div>",
            "      {/* Your component JSX */}",
            "    </div>",
            "  );",
            "};",
            "",
            "export default ",
          }),
          rep(1),
          t(";"),
        }),
      })

      ls.add_snippets("typescriptreact", {
        s("debugg", {
          t("style={{border: '1px solid red'}}"),
        }),
      })

      vim.keymap.set("i", "<C-b>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          print("nothing jumpable")
        end
      end)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
