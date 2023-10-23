local M = {
  path = API.nvim_command_output("echo stdpath('cache')") .. "/plan.nvim/"
}

function M.getNames()
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

function M.save(filename, content)
  vim.cmd("silent !mkdir -p " .. M.path)

  local file = io.open(M.path .. filename, "w")

  for _, value in ipairs(content) do
    file:write(value .. "\n")
  end

  file:close()
end

function M.load(filename)
	local file = io.open(M.path .. filename, "r")

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

  return output
end

function M.remove(filename)
  os.remove(M.path .. filename)
end

return M
