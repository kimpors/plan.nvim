local M = {
  index = 1,
  length = 0,
  list = {},
}

function M.current(value)
  if not (value == nil) then
    M.list[M.index] = value
  else
    return M.list[M.index]
  end
end

function M.next()
  M.index = M.index + 1

  if M.index > M.length then
    M.index = M.index - 1
    return false
  end

  return true
end

function M.previous()
  M.index = M.index - 1

  if M.index < 1 then
    M.index = 1
    return false
  end

  return true
end

function M.add(opts)
  M.length = M.length + 1

  if type(opts) == "string" then
    table.insert(M.list, opts)
  end
end

function M.remove(index)
  if M.length > 0 then
    M.length = M.length - 1
    table.remove(M.list, index)
  end
end

return M
