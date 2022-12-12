#!/bin/sh

set -eu

SSH_PATH="$HOME/.ssh"
SSH_FILE_PATH="$SSH_PATH/ssh_key"

if [ ! -d "$SSH_PATH" ]; then
  mkdir "$SSH_PATH"
fi

if [ ! -f "$SSH_FILE_PATH" ]; then
  touch "$SSH_FILE_PATH"
fi

echo "$INPUT_KEY" > "$SSH_FILE_PATH"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_FILE_PATH"

echo Connecting to ssh host

sh -c "ssh $INPUT_HOST -l $INPUT_USER -p $INPUT_PORT -i $SSH_FILE_PATH"

echo Connecting to ssh host success
echo Executing command

sh -c "$INPUT_COMMAND"

echo Executung command success
