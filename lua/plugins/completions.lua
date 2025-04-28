return {
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local rep = require("luasnip.extras").rep
      require("luasnip").config.set_config({
        history = true,
        enable_autosnippets = true,
      })

      ls.add_snippets("sh", {
        s("shebang", {
          t("#!/bin/bash"),
        }),
      })

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

      ls.add_snippets("go", {
        s("iferr", {
          t("if err != nil {"),
          t({ "", "\t" }),
          i(1, "/* handle error */"),
          t({ "", "}" }),
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
    "saghen/blink.cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
      },
      { "fang2hou/blink-copilot" },
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "enter" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = { documentation = { auto_show = true } },
      snippets = { preset = "luasnip" },
      sources = {
        per_filetype = {
          sql = {
            "snippets",
            "dadbod",
            "buffer",
          },
        },
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 3,
            },
          },
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
