return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua","bash","markdown","markdown_inline",
      "javascript","typescript","tsx",
      "json","css","html","yaml","toml","prisma"
    },
    highlight = { enable = true },
    indent    = { enable = true },
    autotag   = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

