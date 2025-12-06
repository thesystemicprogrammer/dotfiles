# Dotfiles

Personal configuration files and development environment setup.

## Contents

- **kitty/** - Kitty terminal emulator configuration and themes
- **nvim/** - Neovim editor configuration with Lua-based plugin setup
- **.zshrc** - Zsh shell configuration with oh-my-zsh and powerlevel10k
- **.tmux.conf** - Tmux terminal multiplexer configuration
- **.taskrc** - Taskwarrior task management configuration
- **gitbak.sh** - Automated backup script for dotfiles with security checks

## Key Features

### Shell (Zsh)
- Powerlevel10k theme for enhanced prompt
- Integrated tools: direnv, zoxide, kubectl, aws, terraform
- Language support: Go, Python, Rust, Node.js (via SDKMAN)

### Editor (Neovim)
- LSP-based IDE features
- Lazy.nvim plugin management
- Plugins include: blink.cmp, conform, treesitter, neogit, oil.nvim, and more

### Terminal (Kitty + Tmux)
- Gruvbox-inspired color scheme
- Custom keybindings (Ctrl+Space prefix for tmux)
- Session persistence with tmux-resurrect

### Task Management (Taskwarrior)
- Configured task management with `.taskrc`
- Custom data location for cloud storage synchronization
- Integrated with shell for quick task tracking

## Installation

1. Clone this repository:
   ```bash
   git clone git@tsp-github.com:thesystemicprogrammer/dotfiles.git ~/git_backup
   ```

2. **Important:** Update configuration paths for your environment:
   - Edit `.zshrc` and set `CLOUD_STORAGE` to your cloud storage location
   - Edit `.taskrc` and update `data.location` path
   - Edit `nvim/lua/config/keymaps.lua` and update vimwiki path

3. Copy configurations to their expected locations:
   ```bash
   cp -r ~/git_backup/nvim ~/.config/nvim
   cp -r ~/git_backup/kitty ~/.config/kitty
   cp ~/git_backup/.zshrc ~/.zshrc
   cp ~/git_backup/.tmux.conf ~/.tmux.conf
   cp ~/git_backup/.taskrc ~/.taskrc
   ```

   **Alternative:** You can also use symbolic links to keep configs live-linked to the repository:
   ```bash
   ln -s ~/git_backup/nvim ~/.config/nvim
   # Apply same pattern for other configs
   ```

4. Install dependencies:
   - [oh-my-zsh](https://ohmyz.sh/)
   - [powerlevel10k](https://github.com/romkatv/powerlevel10k)
   - [Neovim](https://neovim.io/) (>= 0.9)
   - [Tmux](https://github.com/tmux/tmux)
   - [Kitty](https://sw.kovidgoyal.net/kitty/)
   - [Taskwarrior](https://taskwarrior.org/) - Command-line task management

## Backup

The `gitbak.sh` script automatically backs up configurations with interactive security checks:

```bash
~/git_backup/gitbak.sh
```

### How It Works

The script will:
1. Copy configs from `~/.config` and home directory to `~/git_backup`
2. Scan for sensitive data (passwords, tokens, API keys, secrets, company-specific URLs)
3. **Interactive sanitization** - If sensitive data is detected, you'll be prompted to handle each occurrence
4. Commit and push changes after sanitization

### Interactive Sanitization

When sensitive patterns are detected, the script enters interactive mode and presents each match:

```
════════════════════════════════════════
📄 File: .zshrc
📍 Line 42: export API_KEY="secret123"

Options:
  [r] Replace - edit this line (default)
  [d] Delete - remove this line entirely
  [s] Skip - keep as is
  [a] Abort - stop the backup

Action [r/d/s/a] (default: replace):
```

**Options:**
- **Replace (default)**: Edit the line to remove or sanitize sensitive content. Just press Enter to activate.
- **Delete**: Completely remove the line from the file
- **Skip**: Keep the line unchanged (will be prompted again after re-scan)
- **Abort**: Stop the backup process immediately

**Workflow:**
1. For each sensitive line, choose an action
2. After all lines are processed, the script re-scans for remaining sensitive data
3. If any remain, you can:
   - **Edit again (default)**: Re-enter sanitization mode for remaining items
   - **Continue**: Proceed with backup despite warnings
   - **Abort**: Stop the backup

The script will loop until all sensitive data is sanitized or you choose to continue/abort.

## Security

This repository includes comprehensive security measures to prevent accidental commits of sensitive data:

- **Interactive sanitization**: The backup script detects sensitive patterns and prompts you to sanitize them before committing
- **Pattern matching**: Automatically scans for passwords, tokens, secrets, API keys, and company-specific content
- **Flexible handling**: Choose to replace, delete, or skip each sensitive line individually
- **Re-verification**: After sanitization, the script re-scans to ensure all sensitive data is addressed
- **Excluded files**: `.gitignore` excludes files with company-specific content
- **Safe defaults**: The script excludes itself (`gitbak.sh`) from sensitivity scans

**Detected patterns:**
- `password`, `token`, `secret`, `api_key`, `api-key`
- Company-specific identifiers (e.g., `companyA`, `CompanyB`)

The interactive workflow ensures you maintain full control over what gets committed to the repository.

## License

This is free and unencumbered software released into the public domain. See [LICENSE](LICENSE) for details.
