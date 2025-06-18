vim9script

export final lspServers = [
	# Scripting
	{
		filetype: ["python"],
		path: "pylsp",
		args: [],
	},
	{
		filetype: ["sh"],
		path: "bash-language-server",
		args: ["start"],
	},
	{
		filetype: ["vim"],
		path: "vim-language-server",
		args: ["--stdio"],
	},

	# Systems
	{
		filetype: ["c", "cpp", "objc", "objcpp"],
		path: "clangd",
		args: ["--background-index"],
	},
	{
		filetype: ["rust"],
		path: "rust-analyzer",
		args: [],
	},
	{
		filetype: ["go"],
		path: "gopls",
		args: ["serve"],
	},
	{
		filetype: ["lua"],
		path: "lua-language-server",
		args: [],
	},
	{
		filetype: ["zig", "zir"],
		path: "zls",
		args: [],
	},

	# Web
	{
		filetype: ["html"],
		path: "vscode-html-languageserver",
		args: ["--stdio"],
	},
	{
		filetype: ["css", "scss", "less"],
		path: "vscode-css-languageserver",
		args: ["--stdio"],
	},
	{
		filetype: ["json"],
		path: "vscode-json-languageserver",
		args: ["--stdio"],
	},
	{
		filetype: ["javascript", "typescript", "javascriptreact"],
		path: "typescript-language-server",
		args: ["--stdio"],
	},

	# Other
	{
		filetype: ["terraform", "tf"],
		path: "terraform-ls",
		args: ["serve"],
	},
	{
		filetype: ["r", "rmd"],
		path: "R",
		args: ["--slave", "-e", "languageserver::run()"],
	},
	{
		filetype: ["pdll"],
		path: "./build/bin/mlir-pdll-lsp-server",
		args: []
	},
	{
		filetype: ["cmake"],
		path: "cmake-language-server",
		args: [],
	}
]

filter(lspServers, (idx, val) => executable(val.path))
