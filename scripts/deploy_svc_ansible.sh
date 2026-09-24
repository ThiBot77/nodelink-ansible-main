#!/usr/bin/env bash
set -eu

# useradd et consorts vivent dans /usr/sbin, hors du PATH d'un utilisateur non-root
export PATH="$PATH:/usr/sbin:/sbin"

[ "$(id -u)" -eq 0 ] || { echo "À lancer en root : sudo $0" >&2; exit 1; }

SVC_USER=svc_ansible
PUBKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINS1Jh0bb/z05Di0Ej7g2x9rN0Qhj5ziuxjv2f5m6q8w svc_ansible@nodelink"

id "$SVC_USER" >/dev/null 2>&1 || useradd --create-home --shell /bin/bash --password "*" "$SVC_USER"

install -d -m 0700 -o "$SVC_USER" -g "$SVC_USER" "/home/$SVC_USER/.ssh"
printf '%s\n' "$PUBKEY" > "/home/$SVC_USER/.ssh/authorized_keys"
chown "$SVC_USER:$SVC_USER" "/home/$SVC_USER/.ssh/authorized_keys"
chmod 0600 "/home/$SVC_USER/.ssh/authorized_keys"

echo "$SVC_USER ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$SVC_USER"
chmod 0440 "/etc/sudoers.d/$SVC_USER"

echo "$SVC_USER prêt"
