local wezterm = require("wezterm")

wezterm.on("format-tab-title", function(tab)
	local pane = tab.active_pane
	local title = pane.title
	if pane.domain_name then
		title = '(' .. pane.domain_name .. ') - ' .. title
	end
	return title
end)

local config = {
	check_for_updates = false,
	color_scheme = "Gruvbox dark, medium (base16)",
	font = wezterm.font("Iosevka Term"),
	audible_bell = "Disabled",

	keys = {
		{ mods = "CTRL|SHIFT", key = "D", action = wezterm.action.ShowLauncherArgs { flags = "DOMAINS" } }
	},

	exit_behavior = "CloseOnCleanExit",
	clean_exit_codes = { 130 },
}

local wsl_domains = wezterm.default_wsl_domains()
if next(wsl_domains) then
	for idx, domain in ipairs(wsl_domains) do
		domain.default_cwd = "~"
	end
	config.wsl_domains = wsl_domains
	config.default_domain = wsl_domains[1].name
end

local ssh_hosts = wezterm.enumerate_ssh_hosts()
if next(ssh_hosts) then
	local ssh_domains = {}
	for host, config in pairs(ssh_hosts) do
		table.insert(ssh_domains, { name = host, remote_address = config.hostname, username = config.user })
	end
	config.ssh_domains = ssh_domains
end

return config
