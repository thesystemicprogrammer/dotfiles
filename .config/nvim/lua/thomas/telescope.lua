local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

local actions = require("telescope.actions")
telescope.setup({
	defaults = {

		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		-- Definition for the repo extension
		repo = {
			list = {
				fd_opts = {
					"--no-ignore-vcs",
				},
				search_dirs = {
					"/home/thomas/dev/",
				},
			},
		},
	},
})

telescope.load_extension("repo")
telescope.load_extension("ui-select")
telescope.load_extension("projects")
-- telescope.load_extension "session-lens"
