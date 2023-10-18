local M = {
  path = API.nvim_command_output("echo stdpath('cache')") .. "/plan.nvim/"
}

local msg = { "-_- empty here, don't you think" }

function M.Save(list)
  vim.cmd("silent !mkdir -p " .. M.path)

  local file = io.open(M.path .. "cache", "w")

  for _, value in ipairs(list) do
    file:write(value .. "\n")
  end

  file:close()
end

function M.Load()
	local file = io.open(M.path .. "cache", "r")

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
