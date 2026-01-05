return {
  { "sphamba/smear-cursor.nvim", opts = {} },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({ background_colour = "#1e1e2e", top_down = false })
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        cmdline  = { enabled = true },
        messages = { enabled = true },
        presets  = { lsp_doc_border = true },
      })
    end,
  },
  { "nvim-lualine/lualine.nvim", config = function() require("lualine").setup({ options = { theme = "auto" } }) end },
  { "lewis6991/gitsigns.nvim",   config = true },
}

