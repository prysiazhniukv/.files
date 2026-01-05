-- lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",
    lazy = false,         -- load early
    priority = 1000,      -- before LazyVim uses it
    config = function()
      local snacks = require("snacks")

      snacks.setup({
        image = {
          enabled = true,             -- ✅ enable image rendering
          backend = "magick",         -- fallback if magick available
          integrations = {
            markdown = true,          -- show images in markdown docs
            neorg = true,             -- if you use Neorg
            typst = true,             -- if you render Typst docs
          },
        },
      })

      _G.Snacks = snacks  -- expose global for LazyVim keymaps/util
    end,
  },
}

