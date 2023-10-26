local M = {
  buf = 0,
  win = 0,
}

function Render(opts)
  M.buf = API.nvim_create_buf(true, true)
  M.win = API.nvim_open_win(M.buf, true, opts)
end

function M.window()
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

  return M
end

function M.update(layout)
	API.nvim_buf_set_lines(M.buf, -2, -1, false, layout.header)
	API.nvim_buf_set_lines(M.buf, #layout.header, -1, false, layout.main)
	API.nvim_buf_set_lines(M.buf, (#layout.header + #layout.main), -1, false, layout.footer)
  return M
end

return M
