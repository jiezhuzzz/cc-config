#!/usr/bin/env bash
# This file is used for codespace dotfiles setup https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#enabling-your-dotfiles-repository-for-codespaces

nix run nixpkgs#home-manager -- switch -b backup --flake .#space
