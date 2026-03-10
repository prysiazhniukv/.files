return {
  "stevearc/conform.nvim",
  opts = function()
    local util = require("conform.util")

    return {
      formatters = {
        black = {
          cwd = util.root_file({ "pyproject.toml", ".git" }),
        },
        isort = {
          cwd = util.root_file({ "pyproject.toml", ".git" }),
        },
      },
      formatters_by_ft = {
        python             = { "black", "isort" },
      },
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        local allow = {
          python = true,
        }
        if allow[ft] then
          return { timeout_ms = 2000, lsp_fallback = true }
        end
      end,
    }
  end,
}
