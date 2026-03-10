return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      update_focused_file = { enable = true },
      view                = { width = 30 },
      renderer            = { group_empty = true, highlight_git = true },
      filters             = { dotfiles = true },
      git = { ignore = false },
    })
  vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
    
  function ToggleNvimTreeFocus()
    local view = require("nvim-tree.view")
    if view.is_visible() and vim.api.nvim_get_current_win() == view.get_winnr() then
      -- if you're already in nvim-tree, go back to previous window
      vim.cmd("wincmd p")
    else
      -- otherwise, focus the tree
      vim.cmd("NvimTreeFocus")
    end
  end

  vim.keymap.set("n", "<leader><leader>", ToggleNvimTreeFocus, { silent = true, desc = "Focus File Explorer" })


  end,
}
