if is_home() then
  return {}
end

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = [[
Review the following code.
- Identify correctness issues, edge cases, or hidden bugs.
- Highlight performance or scalability concerns, with reasoning.
- Suggest improvements in clarity, maintainability, or best practices.
- When recommending changes, explain why, and show corrected code snippets when relevant.
- Keep feedback specific and actionable, not generic.
  ]],
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

local mappings = {
  complete = {
    detail = "Use @<Tab> or /<Tab> for options.",
    insert = "<Tab>",
  },
  close = {
    normal = "q",
    insert = "<C-d>",
  },
  reset = {
    normal = "<C-x>",
    insert = "<C-x>",
  },
  submit_prompt = {
    normal = "<CR>",
    insert = "<C-s>",
  },
  accept_diff = {
    normal = "<C-y>",
    insert = "<C-y>",
  },
  show_help = {
    normal = "g?",
  },
}

local keys = {
  {
    "<leader>cp",
    function()
      require("CopilotChat").select_prompt({
        context = {
          "buffers",
        },
      })
    end,
    desc = "CopilotChat - Prompt actions",
  },
  {
    "<leader>cr",
    function()
      local select = require("CopilotChat.select")
      local selection
      local mode = vim.fn.mode()
      if mode == "V" or mode == "V" then
        selection = select.visual
      else
        selection = select.buffer
      end
      require("CopilotChat").ask(prompts.Review, {
        selection = selection,
      })
    end,
    desc = "CopilotChat - Review code",
  },
  { "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat list available models" },
  {
    "<leader>ci",
    function()
      local input = vim.fn.input("Ask Copilot: ")
      if input ~= "" then
        vim.cmd("CopilotChat " .. input)
      end
    end,
    desc = "CopilotChat - Ask input",
  },
  { "<leader>cv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
}

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim", branch = "v3.11.0" },
  },
  build = "make tiktoken",
  opts = {
    system_prompt = [[
You are my coding assistant. Always follow modern TypeScript best practices.
GOALS:
- Be concise in explanations.
- Always use strict typing.
- Prefer async/await over promise chains.
- Use `type` instead of `interface` for object shapes.
- Always specify parameter and return types for functions.
- Use enums instead of union types for static value definitions.
- Keep functions small, focused, and single-responsibility.
- Prefer functions from lodash or @lendis-tech/ libraries when applicable.
- In frontend applications, use the existing styling libraries (Tailwind or Ant Design).
RESTRICTIONS:
- Do not add comments in code unless explicitly requested.
TESTING PRINCIPLES:
- Do not mock library methods or classes by default.
- Only mock if the library component is central to the logic under test and the real implementation is impractical in tests.
]],
    question_header = "## User ",
    answer_header = "## Copilot ",
    error_header = "## Error ",
    prompts = prompts,
    model = "claude-sonnet-4",
    context = {
      "files",
      "git",
    },
    mappings = mappings,
    window = {
      layout = "float", -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
      width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
      height = 0.9, -- fractional height of parent, or absolute height in rows when > 1
      -- Options below only apply to floating windows
      relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
      border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      row = nil, -- row position of the window, default is centered
      col = nil, -- column position of the window, default is centered
      title = "Copilot Chat", -- title of chat window
      footer = nil, -- footer of chat window
      zindex = 1, -- determines if window is on top or below other floating windows
    },
  },
  config = function(_, opts)
    local chat = require("CopilotChat")
    chat.setup(opts)
    local select = require("CopilotChat.select")

    vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = "*", range = true })

    vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = "*", range = true })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-*",
      callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true
        local ft = vim.bo.filetype
        if ft == "copilot-chat" then
          vim.bo.filetype = "markdown"
        end
      end,
    })
  end,
  event = "VeryLazy",
  keys = keys,
}
