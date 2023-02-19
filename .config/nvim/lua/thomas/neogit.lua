local cmp_status_ok, neogit = pcall(require, "neogit")
if not cmp_status_ok then
	return
end

neogit.setup()
