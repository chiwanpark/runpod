#!/bin/bash

# set up ssh private key if provided
if [ -n "${SSH_PRIVATE_KEY}" ]; then
  mkdir -p /root/.ssh
  echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
  ssh-keyscan -H github.com >> /root/.ssh/known_hosts
fi

env | grep -v "SSH_PRIVATE_KEY" > /etc/environment

mkdir -p /workspace/logs /workspace/hf-cache /run/sshd
chmod 755 /run/sshd
chmod 600 /root/.ssh/authorized_keys

/bin/uv run supervisord -c /etc/supervisord.conf
