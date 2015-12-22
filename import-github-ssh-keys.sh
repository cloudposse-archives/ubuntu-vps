#!/bin/bash -ue
GITHUB_USERS="$1"
USER="${2:-dev}"
USER_HOME=$(getent passwd "$USER" | cut -d: -f6)
SSH_CONFIG_DIR="$USER_HOME/.ssh"
SSH_AUTHORIZED_KEYS="$SSH_CONFIG_DIR/authorized_keys"

if [ ! -d "$USER_HOME" ]; then
  echo "Home directory $USER_HOME does not exist!"
  exit 1
fi

[ -d "$SSH_CONFIG_DIR" ] || mkdir -p "$SSH_CONFIG_DIR" -m 0700

echo "$GITHUB_USERS" | tr ', ' '\n' | xargs -I'{}' curl --silent 'https://api.github.com/users/{}/keys' | grep '"key":' | cut -d'"' -f4 > "$SSH_AUTHORIZED_KEYS"

if [ ! -f "$SSH_CONFIG_DIR/config" ]; then
  echo -e '\nHost github.com\n  StrictHostKeyChecking no\n  UserKnownHostsFile=/dev/null' >> "$SSH_CONFIG_DIR/config"
  echo -e '\nHost gitlab.com\n  StrictHostKeyChecking no\n  UserKnownHostsFile=/dev/null' >> "$SSH_CONFIG_DIR/config"
fi

chown "$USER" -R "$SSH_CONFIG_DIR"
