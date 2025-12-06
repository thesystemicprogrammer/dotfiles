# Dotfiles

Personal configuration files and development environment setup.

## Contents

- **kitty/** - Kitty terminal emulator configuration and themes
- **nvim/** - Neovim editor configuration with Lua-based plugin setup
- **opencode/** - OpenCode editor configuration (when backed up)
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

## Backup

The `gitbak.sh` script automatically backs up configurations with security checks:

```bash
~/git_backup/gitbak.sh
```

The script will:
- Scan for sensitive data (passwords, tokens, company-specific URLs)
- Exit with an error if sensitive content is detected
- Copy configs from `~/.config` and home directory
- Commit and push changes if security checks pass

## Security

This repository includes security measures to prevent accidental commits of sensitive data:
- `.gitignore` excludes files with company-specific content
- Backup script includes pattern matching for sensitive strings
- Configuration files use generic placeholders instead of company-specific paths

## License

This is free and unencumbered software released into the public domain. See [LICENSE](LICENSE) for details.
