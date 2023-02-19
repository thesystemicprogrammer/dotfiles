local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

which_key.setup = {
  plugins = {
    active = true,
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  },
}

which_key.register(
  {
    [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
    ["e"] = { "<cmd>NvimTreeFindFileToggle<cr>", "Toggle Tree" },
    ["f"] = { "<cmd>Telescope find_files<cr>", "Find Files" },
    ["m"] = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview Toggle" },
    ["r"] = { "<cmd>Telescope oldfiles<cr>", "Find Recent Files" },
    ["R"] = { "<cmd>Telescope repo list<cr>", "Search Repositories" },
    ["h"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
    b = {
      name = "Buffers",
      j = { "<cmd>BufferLinePick<cr>", "Jump" },
      f = { "<cmd>Telescope buffers<cr>", "Find" },
      b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
      e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
      h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
      D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
      L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    },
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    g = {
      name = "Git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = {
        "<cmd>Telescope git_bcommits<cr>",
        "Checkout commit(for current file)",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
    },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope live_grep<cr>", "Text" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      p = {
        "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
    },
    t = {
      name = "Tools",
      h = { "<Plug>RestNvim", "HTTP call Execute" },
      p = { "<Plug>RestNvimPreview", "HTTP call Preview " },
      r = { "<Plug>RestNvimLast", "HTTP call Re-run" },
    },
    x = {
      name = "Trouble",
      x = { "<cmd>TroubleToggle<cr>", "Trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
    },
    z = {
      name = "Zettelkasten",
      n = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "Create new node with title" },
      o = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Open notes" },
      t = { "<Cmd>ZkTags<CR>", "Open notes by tags" },
      p = { "<Cmd>MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
    },
  },
  {
    prefix = "<leader>"
  }
)
