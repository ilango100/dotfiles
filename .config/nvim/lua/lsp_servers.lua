local nvim_lsp = require('lspconfig')

local function on_attach(_, bufnr)
	-- Save diagnostic status
	vim.b.diagnostic_enabled = true

	local opts = { buffer = bufnr }

	-- Set key mapping
	vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
	-- Using tagfunc is better, but it splits horizontal by default
	-- vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
	vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
	local function split_goto_definition()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end

	vim.keymap.set('n', '<C-w><C-]>', split_goto_definition, opts)
	vim.keymap.set('n', '<C-w>]', split_goto_definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<leader>e', vim.diagnostic.setloclist, opts)
	vim.keymap.set('n', '<leader>E', function()
		if vim.b.diagnostic_enabled then
			vim.diagnostic.disable(0)
			vim.b.diagnostic_enabled = false
		else
			vim.diagnostic.enable(0)
			vim.b.diagnostic_enabled = true
		end
	end, opts)
	vim.keymap.set('n', '==', vim.lsp.buf.formatting, opts)
	vim.keymap.set('x', '=', vim.lsp.buf.range_formatting, opts)
end

local lsp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_flags = { debounce_text_changes = 150 }

-- LSP servers
local servers = {
	-- Script
	'pylsp', 'bashls', 'vimls',
	-- Systems
	'clangd', 'gopls', 'rust_analyzer', 'java_language_server',
	-- Web
	'html', 'cssls', 'jsonls', 'tsserver', 'svelte',
	-- Other
	'texlab', 'terraformls', 'r_language_server'
}
local server_cmds = {
	java_language_server = { "java_language_server" },
	html = { "vscode-html-languageserver", "--stdio" },
	jsonls = { "vscode-json-languageserver", "--stdio" },
}
for _, lsp in ipairs(servers) do
	local setup_config = {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = lsp_capabilities,
	}
	local cmd = server_cmds[lsp]
	if cmd then
		setup_config.cmd = cmd
	end
	nvim_lsp[lsp].setup(setup_config)
end
