-- gopls - Go Language Server
-- https://github.com/golang/tools/tree/master/gopls
-- Install: go install golang.org/x/tools/gopls@latest

return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedwrite = true,
      },
      staticcheck = true, -- Enable staticcheck linting
      gofumpt = true, -- Use gofumpt for formatting via LSP
    },
  },
}
