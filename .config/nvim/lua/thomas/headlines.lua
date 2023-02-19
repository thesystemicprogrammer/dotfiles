local status_ok, headlines = pcall(require, "headlines")
if not status_ok then
  return
end

headlines.setup {
  markdown = {
    fat_headlines = false,
  },
  org = {
    fat_headlines = false,
  }
}
