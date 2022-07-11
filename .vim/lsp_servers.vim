vim9script

# Script
if executable("pylsp")
	autocmd User lsp_setup lsp#register_server({
	\	name: "pylsp",
	\	cmd: (server_info) => ["pylsp"],
	\	allowlist: ["python"]
	\})
endif
if executable("bash-language-server")
	autocmd User lsp_setup lsp#register_server({
	\	name: "bash-language-server",
	\	cmd: (server_info) => ["bash-language-server", "start"],
	\	allowlist: ["sh"]
	\})
endif
if executable("vim-language-server")
	autocmd User lsp_setup lsp#register_server({
	\	name: "vim-language-server",
	\	cmd: (server_info) => ["vim-language-server", "--stdio"],
	\	allowlist: ["vim"]
	\})
endif

# Systems
if executable("clangd")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "clangd",
	\	cmd: (server_info) => ["clangd", "--background-index"],
	\	allowlist: ["c", "cpp", "objc", "objcpp"]
	\})
endif
if executable("rust-analyzer")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "rust-analyzer",
	\	cmd: (server_info) => ["rust-analyzer"],
	\	allowlist: ["rust"]
	\})
endif
if executable("java-language-server")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "java-language-server",
	\	cmd: (server_info) => ["java-language-server"],
	\	allowlist: ["java"]
	\})
endif
if executable("lua-language-server")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "lua-language-server",
	\	cmd: (server_info) => ["lua-language-server"],
	\	allowlist: ["lua"],
	\	workspace_config: {Lua: {
	\		runtime: {
	\			version: "LuaJIT"
	\		},
	\		diagnostics: {
	\			globals: ["vim"]
	\		},
	\		telemetry: {
	\			enable: v:false
	\		}
	\	}}
	\})
endif

# Web
if executable("vscode-html-languageserver")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "html",
	\	cmd: (server_info) => ["vscode-html-languageserver", "--stdio"],
	\	allowlist: ["html"]
	\})
endif
if executable("vscode-css-languageserver")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "css",
	\	cmd: (server_info) => ["vscode-css-languageserver", "--stdio"],
	\	allowlist: ["css", "scss", "less"]
	\})
endif
if executable("vscode-json-languageserver")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "json",
	\	cmd: (server_info) => ["vscode-json-languageserver", "--stdio"],
	\	allowlist: ["json"]
	\})
endif
if executable("typescript-language-server")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "tsserver",
	\	cmd: (server_info) => ["typescript-language-server", "--stdio"],
	\	allowlist: ["javascript", "typescript"]
	\})
endif

# Other
if executable("texlab")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "texlab",
	\	cmd: (server_info) => ["texlab"],
	\	allowlist: ["tex", "bib"]
	\})
endif
if executable("terraform-ls")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "terraformls",
	\	cmd: (server_info) => ["terraform-ls", "serve"],
	\	allowlist: ["terraform", "tf"]
	\})
endif
if executable("R")
	autocmd User lsp_setup call lsp#register_server({
	\	name: "r_language_server",
	\	cmd: (server_info) => ["R", "--slave", "-e", "languageserver::run()"],
	\	allowlist: ["r", "rmd"]
	\})
endif
