# SSH-Action

This is a simple action which only offers the bare minimum of options to execute a command on a remote host via ssh. The
action only supports ssh keys currently, further options might be added in the future.

### How to use this action

It is recommended to set the values for the action as secret, you can do this in your repository settings. An example
workflow which uses this action would look like the following.

```yml
on:
  workflow_dispatch:

jobs:
  name: Execute remote command
  runs-on: ubuntu-latest
  steps:
    - name: Hello world
      uses: c-schicho/SSH-Action@v1
      with:
        host: ${{ secrets.SSH_HOST }}
        port: ${{ secrets.SSH_PORT }}
        user: ${{ secrets.SSH_USER }}
        key: ${{ secrets.SSH_KEY }}
        command: echo Hello world!
```

The port is optional and only needs to be specified when the used port is not the default port `22`.