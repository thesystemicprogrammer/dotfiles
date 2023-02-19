local status_ok, orgmode = pcall(require, "orgmode")
if not status_ok then
  return
end

orgmode.setup_ts_grammar()

orgmode.setup {
	org_agenda_files = {'/home/thomas/Documents/zk/orgmode/*'},
	org_default_notes_file = {'/home/thomas/Documents/zk/orgmode/refile.org'}
}


