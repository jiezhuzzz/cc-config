#!/usr/bin/env bash
# Attach a lease's reserved floating IPs to its instances
# Usage: attach-floating-ips.sh <lease-name>
# Assumes instances are named <lease-name>-1, <lease-name>-2, etc.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CHI="$SCRIPT_DIR/chi.sh"

LEASE_NAME="${1:?Usage: $0 <lease-name>}"

echo "Fetching floating IP reservation ID for lease '$LEASE_NAME'..."
fip_res_id=$("$CHI" blazar lease-show "$LEASE_NAME" -f json | jaq -r '.reservations' | jaq -r 'select(.resource_type=="virtual:floatingip") | .id')

if [ -z "$fip_res_id" ]; then
  echo "ERROR: No floating IP reservation found for lease '$LEASE_NAME'" >&2
  exit 1
fi
echo "Floating IP reservation: $fip_res_id"

echo "Finding floating IPs tagged with reservation:$fip_res_id..."
lease_fips=()
while IFS= read -r ip; do
  tags=$("$CHI" openstack floating ip show "$ip" -f json | jaq -r '.tags[]' 2>/dev/null || true)
  if echo "$tags" | grep -q "reservation:$fip_res_id"; then
    lease_fips+=("$ip")
  fi
done < <("$CHI" openstack floating ip list -f json | jaq -r '.[] | .["Floating IP Address"]')

if [ ${#lease_fips[@]} -eq 0 ]; then
  echo "ERROR: No floating IPs found for reservation $fip_res_id" >&2
  exit 1
fi
echo "Found ${#lease_fips[@]} floating IPs: ${lease_fips[*]}"

echo "Attaching floating IPs to instances..."
for i in "${!lease_fips[@]}"; do
  idx=$((i + 1))
  instance="$LEASE_NAME-$idx"
  fip="${lease_fips[$i]}"
  echo "  $instance <- $fip"
  ("$CHI" openstack server add floating ip "$instance" "$fip")
done

echo ""
echo "Verifying..."
("$CHI" openstack server list -f json | jaq ".[] | select(.Name | startswith(\"$LEASE_NAME\")) | {Name, Status, Networks}")

echo "Done."
