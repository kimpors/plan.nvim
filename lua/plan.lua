local M = {}

function M.Next()
  if PLANS.next() then
    API.nvim_win_set_cursor(UI.win, { PLANS.index, 0 })
  end
end

function M.Previous()
  if PLANS.previous() then
    API.nvim_win_set_cursor(UI.win, { PLANS.index, 0 })
  end
end

function M.Add()
  PLANS.add("")
  Update()

  PLANS.index = PLANS.length
  API.nvim_win_set_cursor(UI.win, { PLANS.length, 0 } )
  API.nvim_command(":star")
end

function M.Save(format)
  API.nvim_win_set_cursor(UI.win, { PLANS.index, 0 })

  local save = API.nvim_buf_get_lines(UI.buf, PLANS.index - 1, PLANS.index, true)

  PLANS.current(format .. save[1])
  Update()
end

function M.ToPlans()
  M.Exit()
  M.Dialog()
end

function M.Exit()
  API.nvim_win_close(UI.win, true)
end


function M.Switch()
  local current = PLANS.list[PLANS.index]

  if current:sub(2, 2) == "x" then
    current = current:sub(1, 1) .. current:sub(3)
  else
    current = current:sub(1, 1) .. "x" .. current:sub(2)
  end

  PLANS.list[PLANS.index] = current
  Update()
end

function M.Remove()
  PLANS.remove(PLANS.index)
  API.nvim_del_current_line()

  if PLANS.next() then
    PLANS.index = PLANS.index - 1
  end
end

function M.RemovePlan()
  STATE.remove(PLANS.list[PLANS.index])
  PLANS.remove(PLANS.index)
  API.nvim_del_current_line()

  if PLANS.next() then
    PLANS.index = PLANS.index - 1
  end
end

function Update()
	API.nvim_buf_set_lines(UI.buf, 0, -1, false, PLANS.list)
end

function M.Dialog()
  PLANS.list = STATE.getNames()
  PLANS.index = 1
  PLANS.length = #PLANS.list

  UI.window(PLANS.list)

  KEYMAP.set(UI.buf,
  {
    j = "Next()",
    k = "Previous()",
    l = "Open(PLANS.list[PLANS.index])",
    x = "RemovePlan()",
    a = "Add()",
    q = "Exit()"
  })

  API.nvim_create_autocmd("InsertLeave",{
    callback = function ()
      M.Save("")
      STATE.save(PLANS.list[PLANS.index], {})
    end,
    buffer = UI.buf})

  API.nvim_create_autocmd("BufLeave",{
    callback = function ()
      M.Exit()
    end,
    buffer = UI.buf})
end

function M.Open(filename)
  PLANS.list = STATE.load(filename)
  PLANS.index = 1
  PLANS.length = #PLANS.list

  UI.window(PLANS.list)

  KEYMAP.set(UI.buf,
  {
    j = "Next()",
    k = "Previous()",
    l = "Switch()",
    x = "Remove()",
    a = "Add()",
    h = "ToPlans()",
    q = "Exit()"
  })

  API.nvim_create_autocmd("InsertLeave",{
    callback = function ()
      M.Save("[]\t")
    end,
    buffer = UI.buf})

  API.nvim_create_autocmd("BufLeave",{
    callback = function ()
      STATE.save(filename, PLANS.list)
    end,
    buffer = UI.buf})
end

return M
