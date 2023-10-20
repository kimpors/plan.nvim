local M = {}

function M.Set(buf, keymaps)
	local except = ""

	for key, _ in pairs(keymaps) do
		except = except .. key
	end

	local chars = {}
	for i = ("a"):byte(), ("z"):byte(), 1 do
		if not string.find(string.char(i), "[" .. except .. "]") then
			table.insert(chars, string.char(i))
		end
	end

	local opts = {
		nowait = true,
		noremap = true,
		silent = true,
	}

	for key, value in pairs(keymaps) do
		API.nvim_buf_set_keymap(buf, "n", key, ":lua require'" .. "plan" .. "'." .. value .. "<CR>", opts)
	end

	for _, value in pairs(chars) do
		API.nvim_buf_set_keymap(buf, "n", value, "", opts)
		API.nvim_buf_set_keymap(buf, "n", value:upper(), "", opts)
		API.nvim_buf_set_keymap(buf, "n", "<C-" .. value .. ">", "", opts)
	end
end

return M
