# LSP Server Installation Guide

This guide provides installation instructions for all LSP servers configured in this Neovim setup.

## Overview

As of the Neovim 0.11+ modernization, LSP servers are **not** automatically installed via Mason. You must install them manually using your system package manager or language-specific tools.

## Installation Commands

### Bash - bash-language-server

**Installation:**
```bash
npm install -g bash-language-server
```

**Verification:**
```bash
bash-language-server --version
```

**Documentation:** https://github.com/bash-lsp/bash-language-server

---

### JSON - vscode-json-language-server

**Installation:**
```bash
npm install -g vscode-langservers-extracted
```

**Verification:**
```bash
vscode-json-language-server --help
```

**Documentation:** https://github.com/hrsh7th/vscode-langservers-extracted

---

### Lua - lua-language-server

**Installation (Homebrew):**
```bash
brew install lua-language-server
```

**Installation (Manual):**
Download from releases: https://github.com/LuaLS/lua-language-server/releases

**Verification:**
```bash
lua-language-server --version
```

**Documentation:** https://luals.github.io/#neovim-install

---

### Markdown - marksman

**Installation (Homebrew):**
```bash
brew install marksman
```

**Installation (Manual):**
Download binary from: https://github.com/artempyanykh/marksman/releases

**Verification:**
```bash
marksman --version
```

**Documentation:** https://github.com/artempyanykh/marksman

---

### Python - pyright

**Installation (npm):**
```bash
npm install -g pyright
```

**Installation (pipx):**
```bash
pipx install pyright
```

**Verification:**
```bash
pyright --version
```

**Documentation:** https://github.com/microsoft/pyright

**Available Commands:**
- `:LspPyrightOrganizeImports` - Organize Python imports
- `:LspPyrightSetPythonPath <path>` - Set Python interpreter path

---

### TOML - taplo

**Installation:**
```bash
cargo install --features lsp --locked taplo-cli
```

**Verification:**
```bash
taplo --version
```

**Documentation:** https://taplo.tamasfe.dev/cli/usage/language-server.html

---

### Typst - tinymist

**Installation:**
```bash
cargo install --git https://github.com/Myriad-Dreamin/tinymist
```

**Verification:**
```bash
tinymist --version
```

**Documentation:** https://github.com/Myriad-Dreamin/tinymist

**Available Commands:**
- `:LspTinymistExportPdf` - Export to PDF
- `:LspTinymistExportPng` - Export to PNG
- `:LspTinymistExportSvg` - Export to SVG
- `:LspTinymistExportMarkdown` - Export to Markdown
- `:LspTinymistExportText` - Export to plain text
- `:LspTinymistGetServerInfo` - Get server information
- `:LspTinymistPinMain` - Pin main file

---

### YAML - yaml-language-server

**Installation:**
```bash
npm install -g yaml-language-server
```

**Verification:**
```bash
yaml-language-server --version
```

**Documentation:** https://github.com/redhat-developer/yaml-language-server

---

## Formatters (for Conform)

These tools are used by the Conform plugin for code formatting.

### stylua (Lua)

**Installation (Cargo):**
```bash
cargo install stylua
```

**Installation (Homebrew):**
```bash
brew install stylua
```

**Verification:**
```bash
stylua --version
```

---

### black (Python)

**Installation (pip):**
```bash
pip install black
```

**Installation (pipx - recommended):**
```bash
pipx install black
```

**Verification:**
```bash
black --version
```

---

## Troubleshooting

### Check LSP Status
```vim
:checkhealth vim.lsp
:LspInfo
```

### Check Formatter Status
```vim
:ConformInfo
```

### Common Issues

**LSP server not starting:**
- Verify the binary is in your `$PATH`
- Check `:checkhealth vim.lsp` for errors
- Ensure the file has a recognized filetype (`:set filetype?`)

**Formatter not working:**
- Run `:ConformInfo` to see detected formatters
- Verify the formatter binary is installed and in `$PATH`

---

## Quick Install All (Example)

If you have all package managers available:

```bash
# LSP Servers
npm install -g bash-language-server vscode-langservers-extracted pyright yaml-language-server
brew install lua-language-server marksman
cargo install --features lsp --locked taplo-cli
cargo install --git https://github.com/Myriad-Dreamin/tinymist

# Formatters
cargo install stylua
pipx install black
```

**Note:** Adjust based on your available package managers.
