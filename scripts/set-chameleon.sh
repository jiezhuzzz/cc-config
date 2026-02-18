#!/usr/bin/env bash
set -euo pipefail

# @arg ips+       Positional param

eval "$(argc --argc-eval "$0" "$@")"

for ip in "${argc_ips[@]}"; do
    # copy 1password token and envs
    scp ~/.envs cc@"$ip":~/.envs
    scp ~/.op-token cc@"$ip":~/.op-token
    # update and upgrade packages
    ssh cc@"$ip" -- "sudo apt update && sudo apt upgrade -y && sudo apt install -y uidmap"
    # install Nix
    ssh cc@"$ip" -- "curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm"
    # install configuration
    ssh cc@"$ip" -- "nix run nixpkgs#home-manager -- switch --flake github:jiezhuzzz/cc-config#cc"
    ssh cc@"$ip" -- "sudo echo 'trusted-users = root cc' >> /etc/nix/nix.custom.conf"
    # set up the terminfo
    infocmp -x xterm-ghostty | ssh cc@"$ip" -- tic -x -
    echo "Finished setting up $ip"
done
