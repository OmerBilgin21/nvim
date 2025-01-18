return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ts_config = require("nvim-treesitter.configs")
      ts_config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "lua", "javascript", "python", "jsonc", "prisma" },
      })
    end,
  },
}
