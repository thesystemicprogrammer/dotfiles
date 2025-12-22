# Dotfiles

Personal configuration files for development environment.

## Contents

- **Neovim**: Complete IDE-like setup with LSP, plugins, and custom keymaps
- **Kitty**: Terminal emulator configuration with Tokyo Night theme
- **Tmux**: Terminal multiplexer configuration with tmuxp session management
- **Waybar**: Status bar configuration for Wayland compositors
- **Starship**: Custom shell prompt with Catppuccin theme and development-focused modules
- **Niri**: Wayland compositor with tiling window management and custom keybindings
- **Zsh**: Shell configuration with custom settings

## Setup

This repository is organized for use with [GNU Stow](https://www.gnu.org/software/stow/) for easy symlink management.

1. Clone this repository to `~/.dotfiles`
2. Install GNU Stow: `sudo apt install stow` (or equivalent for your distribution)
3. Install required dependencies (Neovim, Kitty, Tmux, etc.)
4. Use Stow to create symlinks:
   ```bash
   cd ~/.dotfiles
   stow .
   ```

This will create the appropriate symlinks in your home directory for all configuration files.

## Key Features

- LSP support for multiple languages (Go, TypeScript, Python, Rust, etc.)
- Modern plugin management with lazy.nvim
- Consistent color scheme across all applications
- Productivity-focused keymaps and workflows