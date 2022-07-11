-- Global {{{

vim.o.hidden = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.fillchars = "vert:│"
vim.o.startofline = false
vim.o.lazyredraw = true
vim.o.scrolloff = 2
vim.o.joinspaces = false

vim.g.mapleader = " "

vim.api.nvim_create_user_command("Q", "mksession! | qall",
	{ desc = "Save session and quit" })

-- }}}
-- Window {{{

vim.o.wrap = false
vim.o.linebreak = true
vim.o.number = true
vim.o.signcolumn = "number"
vim.o.listchars = "eol:$,tab:»-,space:·"

vim.keymap.set("n", "<leader>q", "<Cmd>copen<CR>", { desc = "Open quickfix" })
vim.keymap.set("n", "<leader>l", "<Cmd>lopen<CR>", { desc = "Open loclist" })
vim.keymap.set("n", "<C-W>z", "<Cmd>wincmd z | cclose | lclose<CR>", { desc = "Close quickfix, loclist and preview" })
vim.keymap.set("n", "<C-W>Q", "<Cmd>tabclose<CR>", { desc = "Close tab" })

-- }}}
-- Buffer {{{

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = false

vim.api.nvim_create_user_command("Scratch", "setlocal buftype=nofile | setlocal bufhidden=hide | setlocal noswapfile",
	{ desc = "Make the current buffer a scratch buffer" })

-- }}}
-- Search {{{

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.grepprg = "rg --vimgrep"

-- }}}
-- Plugins {{{

-- paq bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path })
end
local plugins = { "savq/paq-nvim" }

-- General {{{

table.insert(plugins, "tpope/vim-commentary")
table.insert(plugins, "tpope/vim-surround")
table.insert(plugins, "tpope/vim-fugitive")
table.insert(plugins, "tpope/vim-repeat")
table.insert(plugins, "tpope/vim-unimpaired")
table.insert(plugins, "tpope/vim-abolish")

-- }}}
-- Gruvbox {{{

table.insert(plugins, "ellisonleao/gruvbox.nvim")

-- }}}
-- Lualine {{{

table.insert(plugins, "nvim-lualine/lualine.nvim")

vim.o.laststatus = 2
local lualine_ok, lualine = pcall(require, "lualine")
if lualine_ok then
	lualine.setup {
		options = {
			icons_enabled = true,
			theme = "gruvbox",
			section_separators = '',
			component_separators = '|',
			-- globalstatus = true,
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { {
				'diagnostics',
				sources = { 'nvim_diagnostic' },
			}, 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' },
		},
	}
end

-- }}}
-- FZF {{{

table.insert(plugins, "junegunn/fzf")
table.insert(plugins, "junegunn/fzf.vim")
vim.g.fzf_preview_window = {}
vim.keymap.set("n", "<leader>f", "<Cmd>Files<CR>", { desc = "FZF" })
vim.keymap.set("n", "<leader>F", "<Cmd>GFiles --exclude-standard -cmo<CR>", { desc = "FZF Git files" })
vim.keymap.set("n", "<leader>b", "<Cmd>Buffers<CR>", { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>/", "<Cmd>execute 'Rg '.input('Rg /')<CR>", { desc = "FZF Rg" })

-- }}}
-- Fern {{{

table.insert(plugins, "lambdalisue/fern.vim")
table.insert(plugins, "antoinemadec/FixCursorHold.nvim")
table.insert(plugins, "lambdalisue/fern-hijack.vim")
table.insert(plugins, "lambdalisue/nerdfont.vim")
table.insert(plugins, "lambdalisue/fern-renderer-nerdfont.vim")
vim.g["fern#hide_cursor"] = 1
vim.g["fern#renderer"] = "nerdfont"
vim.keymap.set("n", "<leader>x", "<Cmd>Fern . -drawer -toggle<CR>", { desc = "Toggle Fern" })
vim.keymap.set("n", "<leader>X", "<Cmd>Fern . -drawer -reveal=%<CR>", { desc = "Reveal file in Fern" })

vim.api.nvim_create_autocmd("FileType", { pattern = "fern", desc = "Initalize Fern", callback = function()
	vim.wo.number = false
	vim.keymap.set("n", "<C-V>", "<Plug>(fern-action-open:vsplit)", {
		desc = "Open file in vsplit",
		buffer = true
	})
	vim.keymap.set("n", "<C-X>", "<Plug>(fern-action-open:split)", {
		desc = "Open file in hsplit",
		buffer = true
	})
	vim.keymap.set("n", "<C-T>", "<Plug>(fern-action-open:tabedit)", {
		desc = "Open file in new tab",
		buffer = true
	})
end
})

-- table.insert(plugins, "")

-- }}}
-- Zepl {{{

table.insert(plugins, "axvr/zepl.vim")
vim.g.repl_config = {
	python = {
		cmd = "python",
		formatter = vim.fn["zepl#contrib#python#formatter"]
	}
}
vim.api.nvim_create_autocmd("User", { pattern = "ZeplTerminalWinOpen", callback = function() vim.wo.number = false end })

-- }}}
-- Filetype specific {{{

table.insert(plugins, "mattn/emmet-vim")
vim.g.user_emmet_install_global = 0
vim.api.nvim_create_autocmd("FileType",
	{ pattern = { "html", "css" }, command = "EmmetInstall", desc = "Initialize Emmet for HTML and CSS" })

table.insert(plugins, "hashivim/vim-terraform")

table.insert(plugins, "chrisbra/csv.vim")
vim.g.csv_bind_B = 1

-- }}}
-- Vsnip {{{

table.insert(plugins, "hrsh7th/vim-vsnip")
table.insert(plugins, "hrsh7th/vim-vsnip-integ")
table.insert(plugins, "rafamadriz/friendly-snippets")

-- Jump back and forth
vim.keymap.set("i", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true })
vim.keymap.set("s", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true })
vim.keymap.set("i", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", { expr = true })
vim.keymap.set("s", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", { expr = true })

-- Fill $TM_SELECTED_TEXT
vim.keymap.set("x", "s", "<Plug>(vsnip-cut-text)")

-- }}}
-- LSP {{{

table.insert(plugins, "neovim/nvim-lspconfig")
local lspconfig_ok, _ = pcall(require, "lspconfig")
if lspconfig_ok then
	require("lsp_servers")
end

-- }}}
-- nvim-cmp {{{

table.insert(plugins, "hrsh7th/cmp-nvim-lsp")
table.insert(plugins, "hrsh7th/cmp-vsnip")
table.insert(plugins, "hrsh7th/nvim-cmp")
local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		mapping = {
			-- Manual completion
			['<C-Space>'] = cmp.mapping.complete(),

			-- Accept completion
			['<CR>'] = cmp.mapping.confirm({ select = false }),
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' },
		}),
		view = { entries = "native" }
	})
end

-- }}}
-- Tree sitter {{{

table.insert(plugins, {
	"nvim-treesitter/nvim-treesitter",
	run = function()
		vim.cmd("TSUpdate")
	end
})
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if treesitter_ok then
	treesitter.setup {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-n>",
				node_incremental = "<C-n>",
				node_decremental = "<C-p>",
			},
		},
		indent = {
			enable = true,
			-- Problematic indenting in insert mode
			disable = { "python" },
		},
	}
end

-- }}}

require("paq")(plugins)

--- }}}
-- Colorscheme {{{

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

-- }}}
-- Cmdline {{{

vim.o.showcmd = true
vim.o.showmode = false
vim.o.shortmess = "aOTIc"
vim.o.wildmenu = true
vim.o.wildoptions = "pum,tagfile"
vim.o.wildignorecase = true

-- }}}
-- Terminal {{{

vim.api.nvim_create_user_command("T", "new | wincmd J | set winfixheight | resize 15 | terminal <args>", {
	nargs = "*",
	desc = "Open a terminal at the bottom",
})
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", {})
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.wo.number = false
	end,
	desc = "Disable numbers in terminals"
})
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter", "WinEnter" }, {
	pattern = { "term://*", "zepl: *" },
	command = "startinsert",
	desc = "Insert mode when entering terminals"
})

-- Zepl
vim.cmd("runtime zepl/contrib/python.vim")

-- }}}
-- Nvim {{{

-- filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- }}}

-- vim: foldmethod=marker
