local cmp_status_ok, projects = pcall(require, "project_nvim")
if not cmp_status_ok then
	return
end

projects.setup({
	patterns = {
		".git",
		"pom.xml",
		"package.json",
	},
})
