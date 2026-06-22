#!/usr/bin/env zsh
set -euo pipefail

LOG=~/post_install.log
REPO_DIR=~/jira_autobot

if [ -d "$REPO_DIR/.git" ]; then
  echo "$(date) jira_autobot already exists, updating" >> "$LOG"
  git -C "$REPO_DIR" pull >> "$LOG" 2>&1
else
  ssh-keyscan git@github.com> >> ~/.ssh/known_hosts
  git clone git@github.com:rhebron-cw/jira_autobot.git "$REPO_DIR" >> "$LOG" 2>&1
fi

docker-compose -f "$REPO_DIR/compose.yml" up --build -d >> "$LOG" 2>&1
echo "$(date) install.sh ran successfully" >> "$LOG"

# curl -s --form-string "token=$po_app" --form-string "user=$po_usr" --form-string "message=install.sh completed. \n $(docker ps)" https://api.pushover.net/1/messages.json >> ~/post_install.log 2>&1
