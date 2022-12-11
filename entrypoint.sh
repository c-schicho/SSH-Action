#!/bin/sh

SSH_PATH="$HOME/.ssh"
SSH_FILE_PATH="$SSH_PATH/ssh_key"

set -eu

if [ ! -d "$SSH_PATH" ]; then
  mkdir "$SSH_PATH"
fi

echo "$INPUT_KEY" > "$SSH_FILE_PATH"

chmod 700 "$SSH_PATH"
chmod 600 "SSH_FILE_PATH"

echo Connecting to ssh host

timeout "$INPUT_SSH_TIMEOUT" "ssh $INPUT_HOST -l $INPUT_USER -p $INPUT_PORT -i $SSH_FILE_PATH"

if [ $? -eq 124 ]; then
  echo "SSH login timed out"
  exit 1
fi

if [ $? -ne 0 ]; then
  echo "SSH login failed"
  exit 1
fi

echo Executing command

timeout "$INPUT_COMMAND_TIMEOUT" "$INPUT_COMMAND"

if [ $? -eq 124 ]; then
  echo "SSH command execution timed out"
  exit 1
fi

if [ $? -ne 0 ]; then
  echo "SSH command execution failed"
  exit 1
fi
