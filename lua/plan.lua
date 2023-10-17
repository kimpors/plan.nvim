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

function M.Add()
  PLANS.add("")
  Update()

  PLANS.index = PLANS.length
  API.nvim_win_set_cursor(UI.win, { PLANS.length, 0 } )
  API.nvim_buf_set_option(UI.buf, "modifiable", true)
  API.nvim_command(":star")
end

function M.Save()
  local save = API.nvim_buf_get_lines(UI.buf, PLANS.index - 1, PLANS.index, true)
  print(save[1])
  PLANS.list[PLANS.index] = save[1]
  Update()
end

function M.Exit()
  API.nvim_win_close(UI.win, true)
end

function M.Switch()
  local current = PLANS.list[PLANS.index]

  if current:sub(1, 1) == "\t" then
    current = current:sub(2, -1)
  else
    current = "\t" .. current
  end

  PLANS.list[PLANS.index] = current
  Update()
end

function M.Remove()
  PLANS.remove(PLANS.index)
  Update()
end

function Update()
  API.nvim_buf_set_option(UI.buf, "modifiable", true)
	API.nvim_buf_set_lines(UI.buf, 0, -1, false, PLANS.list)
	API.nvim_buf_set_option(UI.buf, "modifiable", false)
end

function M.Open()
  API.nvim_create_autocmd("InsertLeave", { command = "lua require('plan').Save()" })

  UI.Menu(PLANS.list)
  KEYMAP.set(UI.buf,
  {
    k = "MoveUp()",
    j = "MoveDown()",
    o = "Remove()",
    l = "Switch()",
    a = "Add()",
    q = "Exit()"
  })
end

return M
