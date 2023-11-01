local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.check_for_updates = false
config.color_scheme = "GruvboxDark"
config.font = wezterm.font_with_fallback({
	"Iosevka Term",
	{ family = "Symbols Nerd Font Mono", scale = 0.8 }
})
config.audible_bell = "Disabled"
config.keys = {
	{ mods = "CTRL|SHIFT", key = "D", action = wezterm.action.ShowLauncherArgs { flags = "DOMAINS" } },
	{ mods = "CTRL|SHIFT|ALT", key = "D", action = wezterm.action.DetachDomain("CurrentPaneDomain") },
	{ mods = "CTRL", key = "UpArrow", action = wezterm.action.ScrollToPrompt(-1) },
	{ mods = "CTRL", key = "DownArrow", action = wezterm.action.ScrollToPrompt(1) },
}
config.exit_behavior = "CloseOnCleanExit"
config.clean_exit_codes = { 130 }
config.exit_behavior_messaging = "Terse"

local wsl_domains = wezterm.default_wsl_domains()
if next(wsl_domains) then
	config.default_domain = wsl_domains[1].name
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

-- Prepend [<domain>] in tab title
wezterm.on("format-tab-title", function(tab)
	local pane = tab.active_pane
	local title = pane.title
	if pane.domain_name then
		title = '[' .. pane.domain_name .. '] ' .. title
	end
	return title
end)

return config
