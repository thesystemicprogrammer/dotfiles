local cmp_status_ok, toggleterm = pcall(require, "toggleterm")
if not cmp_status_ok then
	return
end

-- Open terminal with F3
vim.keymap.set("n", "<F3>", "<cmd>ToggleTerm<CR>", { silent = true })

toggleterm.setup()
