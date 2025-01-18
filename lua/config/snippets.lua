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
