--
--  Thomas' NVIM configuration
--  based on NVIM kickstart config
--  https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--

---------------------------------------------------------------------------------
--
-- Load the plugins
--
---------------------------------------------------------------------------------
require("thomas.plugins")

---------------------------------------------------------------------------------
--
-- Set options and configurations
--
---------------------------------------------------------------------------------

-- UI and Colorthemes
require("thomas.colorscheme")
require("thomas.indentline")
require("thomas.lualine")
require("thomas.alpha")
require("thomas.tree")
require("thomas.barbar")

-- LSP & Coding
require("thomas.lsp")
require("thomas.null-ls")
-- require("thomas.lsp-signature")
require("thomas.trouble")
require("thomas.comment")

-- Autocompletion
require("thomas.cmp")

-- Highlight, Edit and Code Navigation
require("thomas.treesitter")
require("thomas.autopairs")
require("thomas.surround")

-- Telescope
require("thomas.telescope")

-- GIT
require("thomas.neogit")
require("thomas.gitsigns")

-- Tools
require("thomas.rest")
require("thomas.browse")
require("thomas.toggleterm")

-- Note taking
require("thomas.mdpreview")
require("thomas.neorg")

-- Miscellaneous
require("thomas.options")
require("thomas.keymaps")
require("thomas.which-key")
require("thomas.autocommands")
require("thomas.projects")
require("thomas.impatient")
