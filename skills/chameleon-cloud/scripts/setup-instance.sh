#!/usr/bin/env bash
# Post-instance setup for Chameleon Cloud bare metal instances
# Usage: setup-instance.sh <floating-ip> [<floating-ip2> ...]
set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: $0 <floating-ip> [<floating-ip2> ...]" >&2
  exit 1
fi

for ip in "$@"; do
  echo "=== Setting up $ip ==="

  # Remove stale host key
  ssh-keygen -R "$ip" 2>/dev/null || true

  # Copy env files and op-token
  scp -o StrictHostKeyChecking=accept-new -p ~/.envs cc@"$ip":~/.envs
  scp -p ~/.op-token cc@"$ip":~/.op-token

  # Copy Ghostty terminfo
  infocmp -x xterm-ghostty | ssh cc@"$ip" -- tic -x -

  # System update and install podman dependencies
  ssh cc@"$ip" 'sudo apt update && sudo apt upgrade -y && sudo apt install -y uidmap podman slirp4netns'

  # Allow unprivileged user namespaces (required for podman rootless)
  ssh cc@"$ip" 'sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0 && echo "kernel.apparmor_restrict_unprivileged_userns=0" | sudo tee /etc/sysctl.d/99-userns.conf'

  # Install Nix
  ssh cc@"$ip" 'curl --proto "=https" --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm'

  echo "=== $ip setup complete ==="
done
