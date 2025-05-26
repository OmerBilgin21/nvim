local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement. Point out possible bugs or performance issues if you can identify them. Also please communicate your reasoning for any suggested changes.",
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
    normal = "C-d",
    insert = "C-d",
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
  { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
  { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
  { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
  { "<leader>cR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
  { "<leader>cn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
  { "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat list available models" },
  {
    "<leader>cv",
    ":CopilotChatVisual",
    mode = "x",
    desc = "CopilotChat - Open in vertical split",
  },
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
  { "<leader>cx", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
  { "<leader>cv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
}

if IS_HOME then
  print("this returns!")
  return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "make tiktoken",

    opts = function()
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      -- commands
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      -- default opts
      return {
        -- **point at your Ollama endpoint**
        default_provider = "ollama",
        model = "openhermes:latest",
        context = {
          "buffers",
        },
        providers = {
          ollama = {
            -- Copied from the copilot provider so you get the same message‐shaping
            prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
            prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
            -- list Ollama models
            get_models = function(headers)
              local res, err = require("CopilotChat.utils").curl_get(
                "http://localhost:11434/v1/models",
                { headers = headers, json_response = true }
              )
              if err then
                error(err)
              end
              return vim.tbl_map(function(m)
                return { id = m.id, name = m.id }
              end, res.body.data)
            end,

            -- chat completion endpoint
            get_url = function()
              return "http://localhost:11434/v1/chat/completions"
            end,
            -- **stub embeddings** so it won’t crash if Ollama has no embed model
            embed = function(inputs, headers)
              local res, err = require("CopilotChat.utils").curl_post("http://localhost:11434/v1/embeddings", {
                headers = headers,
                json_request = true,
                json_response = true,
                body = {
                  input = inputs,
                  model = "all-minilm:latest",
                },
              })
              if err then
                error(err)
              end
              -- plugin expects an array of { embedding = [...], index = i }
              return res.body.data
            end,
          },
        },
        -- your key mappings & prompts
        prompts = prompts,
        mappings = mappings,
        question_header = "## User ",
        answer_header = "## Copilot ",
        error_header = "## Error ",
      }
    end,
    keys = keys,
    event = "VeryLazy",
  }
end

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim", branch = "v3.11.0" },
  },
  build = "make tiktoken",
  opts = {
    question_header = "## User ",
    answer_header = "## Copilot ",
    error_header = "## Error ",
    prompts = prompts,
    model = "gpt-4o",
    -- context = {
    --   "buffer",
    -- },
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
