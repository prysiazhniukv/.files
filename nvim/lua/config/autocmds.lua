
-- LSP keymaps (registered early so they fire before plugin config runs)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    if client.server_capabilities.inlayHintProvider then
      pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
    end

    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd",          vim.lsp.buf.definition,                            vim.tbl_extend("force", opts, { desc = "LSP: Go to Definition" }))
    vim.keymap.set("n", "gD",          vim.lsp.buf.declaration,                           vim.tbl_extend("force", opts, { desc = "LSP: Go to Declaration" }))
    vim.keymap.set("n", "grr",         "<cmd>Telescope lsp_references<cr>",               vim.tbl_extend("force", opts, { desc = "LSP: List References" }))
    vim.keymap.set("n", "gi",          vim.lsp.buf.implementation,                        vim.tbl_extend("force", opts, { desc = "LSP: Go to Implementation" }))
    vim.keymap.set("n", "gt",          vim.lsp.buf.type_definition,                       vim.tbl_extend("force", opts, { desc = "LSP: Type Definition" }))
    vim.keymap.set("n", "K",           vim.lsp.buf.hover,                                 vim.tbl_extend("force", opts, { desc = "LSP: Hover Documentation" }))
    vim.keymap.set("n", "<leader>rn",  vim.lsp.buf.rename,                                vim.tbl_extend("force", opts, { desc = "LSP: Rename Symbol" }))
    vim.keymap.set("n", "<leader>ca",  vim.lsp.buf.code_action,                           vim.tbl_extend("force", opts, { desc = "LSP: Code Action" }))
    vim.keymap.set({ "n", "v" }, "<leader>fo",
      function() require("conform").format({ async = true }) end,
      vim.tbl_extend("force", opts, { desc = "Format (Conform)" }))
  end,
})

-- Return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Python default: 4-space indents
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.expandtab   = true
    vim.opt_local.tabstop     = 4
    vim.opt_local.shiftwidth  = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr",      { fg = "#5c5c5c", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr",{ fg = "#ffaa00", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "SignColumn",  { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FoldColumn",  { bg = "NONE" })
  end,
})


