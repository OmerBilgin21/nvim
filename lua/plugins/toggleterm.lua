return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local tt = require("toggleterm")
      local Terminal = require("toggleterm.terminal").Terminal
      local base_setup = {
        size = 20,
        direction = "float",
        float_opts = {
          border = "single",
        },
        title_pos = "center",
      }
      local lazygit_setup = vim.tbl_deep_extend("force", {
        cmd = "lazygit",
        hidden = true,
        title = "LazyGit",
      }, base_setup)
      -- these are in a function because I need it to be executed
      -- on the runtime not at the startup to get the correct current filename
      local function get_test_setup()
        local current_file = vim.fn.expand("%:t")
        local test_command = "npx jest -- " .. current_file
        local test_setup = vim.tbl_deep_extend("force", {
          cmd = test_command,
          close_on_exit = false,
          title = "Test",
        }, base_setup)

        return test_setup
      end

      local lazygit = Terminal:new(lazygit_setup)
      tt.setup(base_setup)

      vim.keymap.set("n", "<leader>tt", function()
        local test_terminal = Terminal:new(get_test_setup())
        test_terminal:toggle()
      end)
      vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]])
      vim.keymap.set({ "i", "n", "t" }, "<C-q>", "<cmd>ToggleTerm<CR>")
      vim.keymap.set({ "i", "n", "t" }, "<M-e>", "<cmd>ToggleTerm<CR>")
      vim.keymap.set({ "i", "n", "t" }, "<M-q>", "<cmd>ToggleTerm<CR>")
      vim.keymap.set({ "i", "n", "t" }, "<A-l>", "<cmd>ToggleTerm<CR>")
      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end)
    end,
  },
}
