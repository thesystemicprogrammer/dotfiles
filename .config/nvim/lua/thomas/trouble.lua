local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	print("trouble not okay")
	return
end

vim.keymap.set("n", "<F4>", "<cmd>TroubleToggle<CR>", { silent = true })

trouble.setup({
	auto_close = true,
})
