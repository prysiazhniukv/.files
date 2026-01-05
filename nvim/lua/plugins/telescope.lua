return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond  = function() return vim.fn.executable("make") == 1 end,
    config = function() pcall(require("telescope").load_extension, "fzf") end,
  },
}

