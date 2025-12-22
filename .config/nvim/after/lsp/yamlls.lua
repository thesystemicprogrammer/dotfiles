-- YAML Language Server
-- https://github.com/redhat-developer/yaml-language-server
-- Install: npm i -g yaml-language-server

return {
  settings = {
    -- Disable Red Hat telemetry
    redhat = { telemetry = { enabled = false } },
    -- Enable formatting (disabled by default in yaml-language-server)
    yaml = { format = { enable = true } },
  },
  on_init = function(client)
    -- Fix formatting capability detection
    -- Since formatting is disabled by default, this ensures the capability is advertised
    client.server_capabilities.documentFormattingProvider = true
  end,
}
