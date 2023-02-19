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
require("thomas.options")
require("thomas.keymaps")
require("thomas.which-key")
require("thomas.autocommands")
require("thomas.autopairs")
require("thomas.colorscheme")
require("thomas.cmp")
require("thomas.lualine")
require("thomas.comment")
require("thomas.telescope")
require("thomas.treesitter")
require("thomas.indentline")
require("thomas.neogit")
require("thomas.gitsigns")
require("thomas.alpha")
require("thomas.tree")
require("thomas.barbar")
require("thomas.lsp")
require("thomas.null-ls")
require("thomas.trouble")
require("thomas.toggleterm")
require("thomas.projects")

-- Note taking
require("thomas.mdpreview")
require("thomas.zk")
-- require("thomas.headlines")
require("thomas.neorg")
