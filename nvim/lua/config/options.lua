
vim.g.mapleader        = " "
vim.opt.termguicolors  = true
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.clipboard      = "unnamedplus"
vim.opt.swapfile       = false
vim.opt.updatetime     = 200
vim.g.lazyvim_check_order = false


vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded" },
})

-- auto-reload when files change on disk for gemini cli 
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermClose", "TermLeave" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- nice notification when a file was reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO, { title = "autoread" })
  end,
})
