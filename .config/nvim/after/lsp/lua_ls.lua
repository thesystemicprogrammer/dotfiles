-- Lua Language Server
-- https://github.com/luals/lua-language-server
-- Install: https://luals.github.io/#neovim-install

return {
  cmd = { '/usr/bin/lua-language-server' },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
    },
  },
}
