--
--  Thomas' NVIM configuration
--  based on NVIM kickstart config
--  https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--

---------------------------------------------------------------------------------
--
-- First Time Packer Installation
--
---------------------------------------------------------------------------------
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

--
-- Autocommand that reloads neovim whenever you save the plugins.lua file
--
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

--
-- Use a protected call so we don't error out on first use
--
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("Packer Status not okay")
	return
end

--
-- Have packer use a popup window
--
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

---------------------------------------------------------------------------------
--
-- Packer Plugin Management
--
---------------------------------------------------------------------------------
return packer.startup(function(use)
	--
	--  Have packer manager handle itself
	--
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	---------------------------------------------------------------------------------
	--
	-- LSP Configuration and Plugins
	--
	---------------------------------------------------------------------------------
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		-- Useful status updates for LSP
		"j-hui/fidget.nvim",

		-- Additional lua configuration, makes nvim stuff amazing
		"folke/neodev.nvim",
	})

	use("mfussenegger/nvim-jdtls")

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- show diagnostics
	use("folke/trouble.nvim")
	---------------------------------------------------------------------------------
	--
	-- Autocompletion
	--
	---------------------------------------------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	})

	-- vs-code like icons for autocompletion
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	---------------------------------------------------------------------------------
	--
	-- Highlight, edit, and navigate code
	--
	---------------------------------------------------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	---------------------------------------------------------------------------------
	--
	-- Telescope
	--
	---------------------------------------------------------------------------------
	use("nvim-telescope/telescope.nvim") -- Fuzzy finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })
	use("nvim-telescope/telescope-symbols.nvim") -- picking symbols and insert them at point
	use("cljoly/telescope-repo.nvim") -- Search filesystem for git repos
	use("nvim-telescope/telescope-ui-select.nvim") -- vim.ui.select to telescope

	---------------------------------------------------------------------------------
	--
	-- Git Version Control
	--
	---------------------------------------------------------------------------------
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("TimUntersberger/neogit")
	use("lewis6991/gitsigns.nvim")

	---------------------------------------------------------------------------------
	--
	-- Note Taking
	--
	---------------------------------------------------------------------------------
	use("mickael-menu/zk-nvim")
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	use("lukas-reineke/headlines.nvim")
	use("nvim-orgmode/orgmode")

	use({
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers",
	})

	--------------------------------------------------------------------------------
	--
	-- Utilities and Miscelaneous
	--
	---------------------------------------------------------------------------------
	use("navarasu/onedark.nvim") -- Theme inspired by Atom
	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
	use("goolord/alpha-nvim") -- Greeter screen
	use("windwp/nvim-autopairs") -- Autopair
	use("nvim-tree/nvim-tree.lua") -- Tree Explorer
	use("nvim-tree/nvim-web-devicons")
	use("folke/which-key.nvim") -- Show popup with possbile key bindings
	use("romgrk/barbar.nvim") -- tab bar
	use("akinsho/toggleterm.nvim")
	use("mbbill/undotree")
	use("ahmedkhalf/project.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
