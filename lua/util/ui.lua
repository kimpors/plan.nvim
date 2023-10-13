local M = {
  buf = 0,
  win = 0,
}

function M.Render(opts)
  M.buf = API.nvim_create_buf(false, true)
  M.win = API.nvim_open_win(M.buf, true, { relative='win', row=1, col=1, width=35, height=5 })

  API.nvim_buf_set_option(M.buf, "modifiable", true)
  API.nvim_buf_set_lines(M.buf, -2, 1, false, opts)
	API.nvim_buf_set_option(M.buf, "modifiable", false)

  return M.buf, M.win
end

return M
