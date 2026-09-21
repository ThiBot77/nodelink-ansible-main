#!/usr/bin/env bash

set -eu

USER=svc_ansible
PUBKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINS1Jh0bb/z05Di0Ej7g2x9rN0Qhj5ziuxjv2f5m6q8w svc_ansible@nodelink"

id "$USER" >/dev/null 2>&1 || useradd --create-home --shell /bin/bash "$USER"

install -d -m 0700 -o "$USER" -g "$USER" "/home/$USER/.ssh"
printf '%s\n' "$PUBKEY" > "/home/$USER/.ssh/authorized_keys"
chown "$USER:$USER" "/home/$USER/.ssh/authorized_keys"
chmod 0600 "/home/$USER/.ssh/authorized_keys"

echo "$USER ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$USER"
chmod 0440 "/etc/sudoers.d/$USER"

echo "$USER prêt"
