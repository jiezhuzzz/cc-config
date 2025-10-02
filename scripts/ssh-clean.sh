#!/usr/bin/env bash
set -eo pipefail

# @describe remove ssh fingerprints
# @arg ips+       IP addresses

eval "$(argc --argc-eval "$0" "$@")"

for ip in "${argc_ips[@]}"; do
    ssh-keygen -R "$ip"
done
