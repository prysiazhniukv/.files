return {
  { "williamboman/mason.nvim",            config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "vtsls","eslint","tailwindcss","emmet_language_server","html","cssls","jsonls",
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local caps      = require("cmp_nvim_lsp").default_capabilities()

      local function on_attach(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
          pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
        end
        local opts = { buffer = bufnr, remap = false, desc = "LSP: " }
        vim.keymap.set("n", "gd",  vim.lsp.buf.definition,      vim.tbl_extend("keep", opts, { desc = opts.desc.."Go to Definition" }))
        vim.keymap.set("n", "gD",  vim.lsp.buf.declaration,     vim.tbl_extend("keep", opts, { desc = opts.desc.."Go to Declaration" }))
        vim.keymap.set("n", "gr",  vim.lsp.buf.references,      vim.tbl_extend("keep", opts, { desc = opts.desc.."List References" }))
        vim.keymap.set("n", "gi",  vim.lsp.buf.implementation,  vim.tbl_extend("keep", opts, { desc = opts.desc.."Go to Implementation" }))
        vim.keymap.set("n", "gt",  vim.lsp.buf.type_definition, vim.tbl_extend("keep", opts, { desc = opts.desc.."Type Definition" }))
        vim.keymap.set("n", "K",   vim.lsp.buf.hover,           vim.tbl_extend("keep", opts, { desc = opts.desc.."Hover Documentation" }))
        vim.keymap.set("n","<leader>rn", vim.lsp.buf.rename,    { buffer = bufnr, desc = "LSP: Rename Symbol" })
        vim.keymap.set("n","<leader>ca", vim.lsp.buf.code_action,{ buffer = bufnr, desc = "LSP: Code Action" })
        vim.keymap.set({ "n","v" },"<leader>fo", function() require("conform").format({ async = true }) end,
          { buffer = bufnr, desc = "Format (Conform)" })
      end

      -- TypeScript: vtsls
      lspconfig.vtsls.setup({
        capabilities = caps,
        on_attach   = on_attach,
        settings = {
          vtsls = { experimental = { maxInlayHintLength = 50 } },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints   = true,
              includeInlayVariableTypeHints            = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints  = true,
              includeInlayEnumMemberValueHints         = true,
            },
            preferences = { importModuleSpecifier = "non-relative" },
          },
          javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
        },
        root_dir = lspconfig.util.root_pattern(
          "package.json","tsconfig.json","jsconfig.json","next.config.*","pnpm-workspace.yaml",".git"
        ),
      })

      -- ESLint: apply fixAll on save
      lspconfig.eslint.setup({
        capabilities = caps,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.code_action({
                context = { only = { "source.fixAll.eslint" } },
                apply = true,
              })
            end,
          })
        end,
        settings = { workingDirectory = { mode = "auto" } },
      })

      -- Tailwind / Emmet / HTML / CSS / JSON
      lspconfig.tailwindcss.setup({ capabilities = caps, on_attach = on_attach })
      lspconfig.emmet_language_server.setup({
        capabilities = caps,
        on_attach = on_attach,
        filetypes = { "html","css","scss","javascriptreact","typescriptreact","tsx","jsx","svelte","vue","astro" },
        init_options = { showExpandedAbbreviation = "always" },
      })
      lspconfig.html.setup({ capabilities = caps, on_attach = on_attach })
      lspconfig.cssls.setup({ capabilities = caps, on_attach = on_attach })
      lspconfig.jsonls.setup({
        capabilities = caps,
        on_attach = on_attach,
        settings = { json = { validate = { enable = true } } },
      })

      -- Optional Prisma
      if lspconfig.prismals then
        lspconfig.prismals.setup({ capabilities = caps, on_attach = on_attach })
      end

      -- Optional Python (uncomment to use)
      -- lspconfig.pyright.setup({ capabilities = caps, on_attach = on_attach })
      -- lspconfig.ruff.setup({ on_attach = on_attach })
    end,
  },
}

