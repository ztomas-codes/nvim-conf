require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "eslint", "rust_analyzer", "jdtls", "vue_ls", "intelephense" }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ra', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end

local lsp = require("lspconfig")

-- Lua LSP
lsp.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

-- TypeScript Server (pro `.ts` a `.js`)
lsp.ts_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact" }, -- mimo `.vue`
    root_dir = lsp.util.root_pattern("package.json", "tsconfig.json", ".git")
}

-- Volar (pouze pro `.vue`)
lsp["vuels"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    root_dir = lsp.util.root_pattern("package.json", "tsconfig.json", ".git"),
}

-- Java LSP
lsp.jdtls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- PHP LSP (Intelephense)
lsp.intelephense.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "php"}, 
    root_dir = lsp.util.root_pattern("composer.json", ".git"),
}

