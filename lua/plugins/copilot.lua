if is_home() then
  return {}
end

return {
  "github/copilot.vim",

  cmd = "Copilot",
  event = "BufWinEnter",
}
