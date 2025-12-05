#!/bin/sh

cp -r ~/.config/kitty ~/git_backup
cp -r ~/.config/nvim ~/git_backup
cp -r ~/.config/opencode ~/git_backup

cp ~/.tmux.conf ~/git_backup
cp ~/.taskrc ~/git_backup
cp  ~/.zshrc ~/git_backup

cd ~/git_backup
git add --all
git commit -m "regular update"
git push

alias dots=~/scripts/gitbak.sh

