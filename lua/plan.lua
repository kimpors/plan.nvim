local M = {}

function M.Open()
  PLANS.add("Hello there")
  PLANS.add("Hello -_-")

  UI.Menu(PLANS.list)
end

return M
