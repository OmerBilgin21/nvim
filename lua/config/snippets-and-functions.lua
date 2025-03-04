-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=200 }
  augroup END
]],
  false
)

local uv = vim.loop

local function has_files_with_extensions(extensions)
  local function scan_dir(dir)
    local handle, err = uv.fs_scandir(dir)
    if not handle then
      return false
    end

    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then
        break
      end

      if type == "file" then
        for _, ext in ipairs(extensions) do
          if name:match("%." .. ext .. "$") then
            return true
          end
        end
      elseif type == "directory" then
        -- Skip directories that you want to ignore.
        if name == "node_modules" or name == "dist" then
          goto continue
        end

        local subdir = dir .. "/" .. name
        if scan_dir(subdir) then
          return true
        end
      end
      ::continue::
    end

    return false
  end

  return scan_dir(uv.cwd())
end

_G.reload_module = function(module_name)
  package.loaded[module_name] = nil
  require(module_name)
  print("Reloaded module: " .. module_name)
end

_G.appendTables = function(destination, source)
  for key, value in pairs(source) do
    destination[key] = value
  end
end

_G.is_react = function()
  return has_files_with_extensions({ "jsx", "tsx", "css" })
end

_G.is_go = function()
  return has_files_with_extensions({ "go" })
end

_G.is_lua = function()
  return has_files_with_extensions({ "lua" })
end
