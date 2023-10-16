local M = {
  index = 1,
  length = 0,
  list = {},
}

function M.next()
  M.index = M.index + 1

  if M.index >= M.length then
    M.index = M.length
  end
end

function M.previous()
  M.index = M.index - 1

  if M.index < 1 then
    M.index = 1
  end
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
