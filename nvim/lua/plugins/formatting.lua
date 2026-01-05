return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript         = { "prettierd", "prettier" },
      javascriptreact    = { "prettierd", "prettier" },
      typescript         = { "prettierd", "prettier" },
      typescriptreact    = { "prettierd", "prettier" },
      json               = { "prettierd", "prettier" },
      jsonc              = { "prettierd", "prettier" },
      css                = { "prettierd", "prettier" },
      scss               = { "prettierd", "prettier" },
      html               = { "prettierd", "prettier" },
      yaml               = { "prettierd", "prettier" },
      markdown           = { "prettierd", "prettier" },
      ["markdown.mdx"]   = { "prettierd", "prettier" },
      prisma             = { "prettier" },
    },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      local allow = {
        javascript=true,javascriptreact=true,typescript=true,typescriptreact=true,
        json=true,jsonc=true,css=true,scss=true,html=true,yaml=true,markdown=true,["markdown.mdx"]=true,prisma=true
      }
      if allow[ft] then
        return { timeout_ms = 2000, lsp_fallback = true }
      end
    end,
  },
}

