-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local modes = { "n", "x", "o", "i" } -- normal, visual, operator-pending, insert

-- Make it easier to press [ and ] with a remap for Swiss German keyboard
vim.opt.langmap = "ö[ä]"
-- Plain langmap remapping does not seem to do the trick :(
vim.keymap.set({ "n", "v", "o" }, "ü", "[", { remap = true })
vim.keymap.set({ "n", "v", "o" }, "ä", "]", { remap = true })

-- Function Mappings
keymap("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })
keymap(
	"n",
	"e: ~/Documents/wiki/index.md<CR>",
	"<Leader>ww",
	{ desc = "Open WIKI Index", noremap = true, silent = true }
)

-- Remap arrow keys
local function warn(msg)
	vim.notify(msg, vim.log.levels.WARN, { title = "Use hjkl" })
end

keymap(modes, "<Left>", function()
	warn("Use h instead of the ← arrow")
end, opts)
keymap(modes, "<Down>", function()
	warn("Use j instead of the ↓ arrow")
end, opts)
keymap(modes, "<Up>", function()
	warn("Use k instead of the ↑ arrow")
end, opts)
keymap(modes, "<Right>", function()
	warn("Use l instead of the → arrow")
end, opts)

-- Use jk or kj for easier ESC
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
