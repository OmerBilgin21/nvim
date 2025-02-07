vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]])

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local tt = require("toggleterm")
      tt.setup({
        size = 20,
        open_mapping = [[<S-l>]],
        direction = "float",
        insert_mappings = false,
        float_opts = {
          border = "single",
        },
        title_pos = "center",
      })
    end,
  },
}
