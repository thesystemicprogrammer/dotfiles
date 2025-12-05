return {
	"nvim-java/nvim-java",
	dependencies = {
		{
			"NickJAllen/java-helpers.nvim",
			opts = {},
			dependencies = {
				{ "nvim-lua/plenary.nvim" },
			},
		},
	},
	config = function()
		require("java").setup()
		vim.lsp.enable("jdtls")
	end,
}
