#!/bin/sh

set -eu

SSH_PATH="$HOME/.ssh"
SSH_KEY_PATH="$SSH_PATH/ssh_key"
SSH_KNOWN_PATH="$SSH_PATH/known_hosts"
COMMAND_PATH="$HOME/command.sh"

if [ ! -d "$SSH_PATH" ]; then
  mkdir "$SSH_PATH"
fi

if [ ! -f "$SSH_KNOWN_PATH" ]; then
  touch "$SSH_KNOWN_PATH"
fi

if [ ! -f "$SSH_KEY_PATH" ]; then
  touch "$SSH_KEY_PATH"
fi

echo "$INPUT_KEY" > "$SSH_KEY_PATH"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_KEY_PATH"
chmod 600 "$SSH_KNOWN_PATH"

echo "$INPUT_COMMAND" > "$COMMAND_PATH"
echo "exit \$?" >> "$COMMAND_PATH"

echo Start exectuting remote command

sh -c "ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no -p $INPUT_PORT ${INPUT_USER}@${INPUT_HOST} < $COMMAND_PATH"

echo Successfully executed remote command
