return {
	{
		"nvim-mini/mini.diff",
		version = false,
		opts = {
			view = {
				-- Visualization style. Possible values are 'sign' and 'number'.
				-- Default: 'number' if line numbers are enabled, 'sign' otherwise.
				style = "sign",
			},
		},
	},
	{ "nvim-mini/mini-git", version = false, main = "mini.git", opts = {} },
	{ "nvim-mini/mini.statusline", version = false, opts = {} },
	{ "nvim-mini/mini.tabline", version = false, opts = {} },
}
