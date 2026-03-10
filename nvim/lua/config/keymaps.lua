local map = vim.keymap.set

-- tmux nav (plugin maps live here, plugin spec is in plugins/tmux.lua)
map("n","<C-h>","<cmd>TmuxNavigateLeft<cr>")
map("n","<C-j>","<cmd>TmuxNavigateDown<cr>")
map("n","<C-k>","<cmd>TmuxNavigateUp<cr>")
map("n","<C-l>","<cmd>TmuxNavigateRight<cr>")

-- Telescope via command (triggers lazy-load)
map("n","<leader>ff","<cmd>Telescope find_files<cr>", { desc = "❖ Find Files" })
map("n","<leader>lg","<cmd>Telescope live_grep<cr>", { desc = "🔍 Live Grep", noremap = true, silent = true })
map("n","<leader>fb","<cmd>Telescope buffers<cr>",    { desc = "❖ Buffers" })
map("n","<leader>fh","<cmd>Telescope help_tags<cr>",  { desc = "❖ Help" })

-- Diagnostics
map("n","gl",  vim.diagnostic.open_float, { desc = "LSP Diagnostic Float" })
map("n","[d",  vim.diagnostic.goto_prev,  { desc = "Prev Diagnostic" })
map("n","]d",  vim.diagnostic.goto_next,  { desc = "Next Diagnostic" })


vim.keymap.set("n", "<F2>", function()
  vim.opt.paste = not vim.opt.paste:get()
  print("paste mode: " .. (vim.opt.paste:get() and "ON" or "OFF"))
end, { desc = "Toggle paste mode" })
