local M = {}

PLANS.add("Hello -_-")
PLANS.add("Here your plans:")

function M.MoveUp()
  PLANS.previous()
  API.nvim_win_set_cursor(UI.win, { PLANS.index, 0 })
end

function M.MoveDown()
  PLANS.next()
  API.nvim_win_set_cursor(UI.win, { PLANS.index, 0 })
end

function M.Open()
  UI.Menu(PLANS.list)
  KEYMAP.set(UI.buf, { k = "MoveUp()", j = "MoveDown()" })
end

return M
