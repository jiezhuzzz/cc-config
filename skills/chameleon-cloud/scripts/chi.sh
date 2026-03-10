#!/usr/bin/env bash
# Chameleon Cloud CLI wrapper
# Usage: chi blazar <args...>  OR  chi openstack <args...>
set -euo pipefail

export OS_AUTH_URL="https://chi.uc.chameleoncloud.org:5000/v3"
export OS_IDENTITY_API_VERSION="3"
export OS_INTERFACE="public"
export OS_PROJECT_ID="e46d806797dc438bbd703f97533ca4d6"
export OS_USERNAME="jiezhu@uchicago.edu"
export OS_PROTOCOL="openid"
export OS_AUTH_TYPE="v3oidcpassword"
export OS_IDENTITY_PROVIDER="chameleon"
export OS_DISCOVERY_ENDPOINT="https://auth.chameleoncloud.org/auth/realms/chameleon/.well-known/openid-configuration"
export OS_CLIENT_ID="keystone-uc-prod"
export OS_ACCESS_TOKEN_TYPE="access_token"
export OS_CLIENT_SECRET="none"
export OS_REGION_NAME="CHI@UC"

if [[ -z "${OS_PASSWORD:-}" ]]; then
  echo "Error: OS_PASSWORD must be set" >&2
  exit 1
fi

cmd="${1:?Usage: chi <blazar|openstack> [args...]}"
shift

case "$cmd" in
  blazar)
    exec uvx --from python-blazarclient blazar "$@"
    ;;
  openstack)
    exec uvx --from python-openstackclient openstack "$@"
    ;;
  *)
    echo "Unknown command: $cmd (use 'blazar' or 'openstack')" >&2
    exit 1
    ;;
esac
