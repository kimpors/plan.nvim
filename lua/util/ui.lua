local M = {
  buf = 0,
  win = 0,
}

function Render(opts)
  M.buf = API.nvim_create_buf(true, true)
  M.win = API.nvim_open_win(M.buf, true, opts)
end

function M.Menu(opts)
  Render({
      relative = "win",
			width = 50,
			height = 20,
			row = 10,
			col = 10,
			style = "minimal",
			border = "rounded",
    })

  API.nvim_buf_set_option(M.buf, "modifiable", true)
  API.nvim_buf_set_lines(M.buf, -2, -1, false, opts)
	API.nvim_buf_set_option(M.buf, "modifiable", false)
end

return M
