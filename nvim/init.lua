-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
    "--branch=stable",
  })

end
vim.opt.rtp:prepend(lazypath)

-- Core config
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugins: load everything from lua/plugins/*
require("lazy").setup({
  { import = "plugins" }, -- every *.lua in lua/plugins
}, {
  ui = { border = "rounded" }
})


