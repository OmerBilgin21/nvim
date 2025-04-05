return {
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    dependencies = {
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

      ls.add_snippets("go", {
        s("iferr", {
          t("if err != nil {"),
          t({ "", "\t" }), -- New line with an indent for the placeholder
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
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
      },
    },
    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "enter" },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
