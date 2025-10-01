return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local tt = require("toggleterm")
      local Terminal = require("toggleterm.terminal").Terminal

      local base_setup = {
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
          else
            return 20
          end
        end,
        direction = "float",
        float_opts = {
          border = "single",
        },
        title_pos = "center",
      }

      local claude_setup = {
        id = 999,
        direction = "vertical",
        cmd = "claude",
        hidden = true,
        title = "Claude Code",
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
      local claude = Terminal:new(claude_setup)
      tt.setup(base_setup)

      vim.keymap.set("n", "<leader>tt", function()
        local test_terminal = Terminal:new(get_test_setup())
        test_terminal:toggle()
      end)

      vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]])
      vim.keymap.set({ "i", "n", "t" }, "<S-tab>", function()
        vim.cmd("1ToggleTerm")
      end, { desc = "Close all terminals or open a new one" })

      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end)
      vim.keymap.set({ "n", "t" }, "<C-Space>", function()
        claude:toggle()
      end)
    end,
  },
}
