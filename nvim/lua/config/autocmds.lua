
-- Return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Web stack default: 2-space indents
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript","javascriptreact","typescript","typescriptreact","tsx","jsx","css","scss","html","json","yaml","toml", "lua" },
  callback = function()
    vim.opt_local.expandtab   = true
    vim.opt_local.tabstop     = 2
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr",      { fg = "#5c5c5c", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr",{ fg = "#ffaa00", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "SignColumn",  { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FoldColumn",  { bg = "NONE" })
  end,
})


