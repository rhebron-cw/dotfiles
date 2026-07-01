#!/usr/bin/env zsh
set -euo pipefail

LOG=~/post_install.log
REPO_DIR1=~/dotfiles
REPO_DIR2=~/jira_autobot

if [ -d "~/.ssh" ]; then
  echo "$(date) ssh/known_hosts exists, continuing" >> "$LOG" 2>&1
  ssh-keyscan github.com >> ~/.ssh/known_hosts >> "$LOG" 2>&1
else
  echo "$(date) created ssh/known_hosts and added github fingerprint" >> "$LOG" 2>&1
  mkdir ~/.ssh >> "$LOG" 2>&1
  ssh-keyscan github.com >> ~/.ssh/known_hosts >> "$LOG" 2>&1
fi

if [ -d "$REPO_DIR1/.git" ]; then
  echo "$(date) dotfiles already exists, updating" >> "$LOG" 2>&1
  git -C "$REPO_DIR1" pull >> "$LOG" 2>&1
else
  git clone git@github.com:rhebron-cw/dotfiles.git "$REPO_DIR1" >> "$LOG" 2>&1
fi

if [ -d "$REPO_DIR2/.git" ]; then
  echo "$(date) jira_autobot already exists, updating" >> "$LOG" 2>&1
  git -C "$REPO_DIR2" pull >> "$LOG" 2>&1
else
  git clone git@github.com:rhebron-cw/jira_autobot.git "$REPO_DIR2" >> "$LOG" 2>&1
fi

#cp ~/dotfiles/.*(.) ~/./
docker-compose -f "$REPO_DIR2/compose.yml" up --build -d >> "$LOG" 2>&1
echo "$(date) install.sh ran successfully" >> "$LOG" 2>&1
