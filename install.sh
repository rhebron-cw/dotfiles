#!/usr/bin/env zsh
set -euo pipefail

LOG=~/post_install.log
REPO_DIR1=~/dotfiles
REPO_DIR2=~/jira_autobot

if [ -d "~/.ssh/known_hosts" ]; then
  echo "$(date) ssh/known_hosts exists, continuing" >> "$LOG"
else
  echo "$(date) created ssh/known_hosts and added github fingerprint" >> "$LOG"
  mkdir ~/.ssh
  ssh-keyscan github.com >> ~/.ssh/known_hosts
fi

if [ -d "$REPO_DIR1/.git" ]; then
  echo "$(date) dotfiles already exists, updating" >> "$LOG"
  git -C "$REPO_DIR1" pull >> "$LOG" 2>&1
else
  git clone git@github.com:rhebron-cw/dotfiles.git "$REPO_DIR" >> "$LOG" 2>&1
fi

if [ -d "$REPO_DIR2/.git" ]; then
  echo "$(date) jira_autobot already exists, updating" >> "$LOG"
  git -C "$REPO_DIR2" pull >> "$LOG" 2>&1
else
  git clone git@github.com:rhebron-cw/jira_autobot.git "$REPO_DIR" >> "$LOG" 2>&1
fi

cp ~/dotfiles/.* ~/
docker-compose -f "$REPO_DIR2/compose.yml" up --build -d >> "$LOG" 2>&1
echo "$(date) install.sh ran successfully" >> "$LOG"

# curl -s --form-string "token=$po_app" --form-string "user=$po_usr" --form-string "message=install.sh completed. \n $(docker ps)" https://api.pushover.net/1/messages.json >> ~/post_install.log 2>&1
