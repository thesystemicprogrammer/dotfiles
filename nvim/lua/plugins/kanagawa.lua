return {
	"rebelot/kanagawa.nvim",
	enabled = false,
	config = function()
		require("kanagawa").setup({
			compile = true,
			transparent = true,
		})
		vim.cmd("colorscheme kanagawa-wave")
	end,
	build = function()
		vim.cmd("KanagawaCompile")
	end,
}
