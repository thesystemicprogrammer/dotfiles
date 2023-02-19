-- Nordic Theme
-- local colorscheme = "nord"

-- Everforest Theme
-- local colorscheme = "everforest"

-- Vim Code Dark
-- local colorscheme = "codedark"

-- Sonokai Theme
-- local colorscheme = "sonokai"
-- vim.g.sonokai_style = "espresso"
-- vim.g.sonokai_better_performance = 1

-- VS Code
-- vim.o.background = "dark"
-- vim.o.background = "light"
-- vim.g.vscode_transparent = 1
-- vim.g.vscode_italic_comment = 1
-- vim.g.vscode_disable_nvimtree_bg = true
-- local colorscheme = "vscode"

local colorscheme = "onedark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
