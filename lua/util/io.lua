local M = {
  path = API.nvim_command_output("echo stdpath('cache')") .. "/plan.nvim/"
}

local msg = { "-_- empty here, don't you think" }

function M.GetFileNames()
  local names = {}
  local i = 0
  local path = API.nvim_command_output("echo stdpath('cache')")
  local files = io.popen("ls " .. path .. "/plan.nvim")

  for name in files:lines() do
    i = i + 1
    names[i] = name
  end

  files:close()
  return names
end

function M.Save(filename, content)
  vim.cmd("silent !mkdir -p " .. M.path)

  local file = io.open(M.path .. filename, "w")

  for _, value in ipairs(content) do
    file:write(value .. "\n")
  end

  file:close()
end

function M.Load(filename)
	local file = io.open(M.path .. filename, "r")

  if file == nil then
    return msg
  end

  local line = ""
  local output = {}
  local index = 1

	while true do
		line = file:read()

		if line == nil then
			break
		end

    output[index] = line
    index = index + 1
	end

	file:close()

  if index == 1 then
    return msg
  end

  return output
end

return M
