-- Angular Language Service
-- Install: npm install -g @angular/language-server
--
-- Note: angularls works alongside ts_ls. It provides:
-- - Angular template completions and diagnostics
-- - Go to definition in templates
-- - Component/directive hover information
--
-- The language server requires a project with angular.json to activate.

return {
  -- Angular LS will only attach to projects with angular.json
  root_markers = { 'angular.json' },
}
