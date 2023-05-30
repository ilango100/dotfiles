local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.check_for_updates = false
config.color_scheme = "GruvboxDark"
config.font = wezterm.font("Iosevka Term")
config.audible_bell = "Disabled"
config.keys = {
	{ mods = "CTRL|SHIFT", key = "D", action = wezterm.action.ShowLauncherArgs { flags = "DOMAINS" } },
	{ mods = "CTRL|SHIFT|ALT", key = "D", action = wezterm.action.DetachDomain("CurrentPaneDomain") },
	{ mods = "CTRL", key = "UpArrow", action = wezterm.action.ScrollToPrompt(-1) },
	{ mods = "CTRL", key = "DownArrow", action = wezterm.action.ScrollToPrompt(1) },
}
config.exit_behavior = "CloseOnCleanExit"
config.clean_exit_codes = { 130 }

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

-- Maximize all displayed windows on startup
wezterm.on('gui-attached', function(domain)
	local workspace = wezterm.mux.get_active_workspace()
	for _, window in ipairs(wezterm.mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

-- Prepend (<domain>) in tab title
wezterm.on("format-tab-title", function(tab)
	local pane = tab.active_pane
	local title = pane.title
	if pane.domain_name then
		title = '(' .. pane.domain_name .. ') - ' .. title
	end
	return title
end)

return config
