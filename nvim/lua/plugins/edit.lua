return {
--  { "github/copilot.vim", lazy = false },
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  { "kylechui/nvim-surround", version = "*", config = true },
  { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end },
  { "windwp/nvim-ts-autotag" }, -- enabled by treesitter config
}

