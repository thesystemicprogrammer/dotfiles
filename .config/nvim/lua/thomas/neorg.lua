local cmp_status_ok, neorg = pcall(require, "neorg")
if not cmp_status_ok then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {
			config = {
				folds = true,
			},
		},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					notes = "~/Documents/zk/neorg",
				},
				default_workspace = "notes",
				open_last_workspace = true,
			},
		},
	},
})
