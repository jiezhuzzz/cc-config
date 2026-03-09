---
name: chameleon-cloud
description: Use when managing Chameleon Cloud resources - creating leases, reservations, launching bare metal instances, managing networks, floating IPs, or any openstack/blazar CLI operations on CHI@UC
---

# Chameleon Cloud Management

Manage bare metal reservations and instances on Chameleon Cloud (CHI@UC) via CLI.
**Assume `jaq` is installed.** Use `-f json` with blazar/openstack and pipe through `jaq` to extract fields.

## CLI Tools

```bash
uvx --from python-openstackclient openstack <command>
uvx --from python-blazarclient blazar <command>
```

## Authentication

**IMPORTANT:** Always ask the user for `OS_PASSWORD` interactively before running any commands. Never store or hardcode it.

```bash
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
# OS_PASSWORD - MUST ask user interactively
```

## Supported Node Types

| Label | node_type value |
|-------|-----------------|
| Skylake | `compute_skylake` |
| Cascade Lake | `compute_cascadelake_r` |

## Reservation Workflow (MUST FOLLOW)

When the user asks to reserve hosts, follow **all steps** in order.

### Step 1: Check Availability

```bash
# Get all host IDs
blazar host-list -f json | jaq -r '.[].id'

# Get allocations — shows which hosts are reserved and when
blazar allocation-list host -f json | jaq '.[] | {resource_id, reservations}'

# Check node_type for a specific host
blazar host-show <id> -f json | jaq -r '.node_type'
```

**Note:** `host-list` does not include `node_type`. Call `blazar host-show <id>` per host. To save time, only query free hosts' types (those without a current allocation covering now).

### Step 2: Analyze and Present

Cross-reference hosts and allocations. Present:

```
Node Availability Summary:
- Skylake (compute_skylake): X total, Y free, Z reserved
  - Next availability (if full): <earliest end_date>
- Cascade Lake (compute_cascadelake_r): X total, Y free, Z reserved
  - Next availability (if full): <earliest end_date>
```

### Step 3: Prompt the User

Ask:
1. **Lease name?**
2. **Which node type?** (Skylake or Cascade Lake)
3. **How many nodes?**
4. **Duration?**
5. **SSH keypair?** (`openstack keypair list -f json | jaq -r '.[].Name'`)
6. **OS image?** (e.g. CC-Ubuntu22.04, CC-Ubuntu24.04)

If requested count exceeds free nodes, show earliest time when enough become free.

### Step 4: Create the Lease

Omit `--start-date` to start immediately. Always include floating IPs (1 per node).

```bash
public_ip=$(openstack network show public -c id -f value)

blazar lease-create \
  --reservation "min=<N>,max=<N>,resource_type=physical:host,resource_properties=[\"=\",\"\$node_type\",\"<type>\"]" \
  --reservation "resource_type=virtual:floatingip,network_id=${public_ip},amount=<N>" \
  --end-date "<YYYY-MM-DD HH:MM>" \
  <lease-name>
```

Wait ~15s for lease to transition from `PENDING` to `ACTIVE`:
```bash
blazar lease-show <lease-name> -f json | jaq -r '.status'
```

### Step 5: Launch Instances

Name them `<lease-name>-1`, `<lease-name>-2`, etc.

```bash
# Get host reservation ID (NOT the lease ID)
reservation_id=$(blazar lease-show <lease-name> -f json | jaq -r '.reservations | map(select(.resource_type=="physical:host")) | .[0].id')

# Get sharednet1 network ID
net_id=$(openstack network show sharednet1 -c id -f value)

# Launch N instances
for i in $(seq 1 <N>); do
  openstack server create \
    --image <image> --flavor baremetal --key-name <keypair> \
    --nic net-id=$net_id --hint reservation=$reservation_id \
    <lease-name>-$i
done
```

Bare metal takes ~10-15 min (BUILD -> ACTIVE). Poll with:
```bash
openstack server list -f json | jaq '.[] | select(.Name | startswith("<lease-name>")) | {Name, Status}'
```

### Step 6: Attach Floating IPs

After instances are ACTIVE, attach the lease's reserved floating IPs.

```bash
# Get the floatingip reservation ID
fip_res_id=$(blazar lease-show <lease-name> -f json | jaq -r '.reservations | map(select(.resource_type=="virtual:floatingip")) | .[0].id')

# Find floating IPs tagged with this reservation
lease_fips=$(openstack floating ip list -f json | jaq -r '.[].["Floating IP Address"]' | while read ip; do
  tags=$(openstack floating ip show "$ip" -f json | jaq -r '.tags[]' 2>/dev/null)
  echo "$tags" | grep -q "reservation:$fip_res_id" && echo "$ip"
done)

# Attach one per instance
i=1
for fip in $lease_fips; do
  openstack server add floating ip <lease-name>-$i $fip
  i=$((i+1))
done
```

Verify:
```bash
openstack server list -f json | jaq '.[] | select(.Name | startswith("<lease-name>")) | {Name, Status, Networks}'
```

SSH: `ssh cc@<floating-ip>`

### Step 7: Post-Instance Setup

After floating IPs are attached and SSH is working, run these setup steps on each instance.

```bash
ip=<floating-ip>

# 1. Copy env files and op-token with proper permissions
scp -p ~/.envs cc@"$ip":~/.envs
scp -p ~/.op-token cc@"$ip":~/.op-token

# 2. Copy Ghostty terminfo so terminal works correctly over SSH
infocmp -x xterm-ghostty | ssh cc@"$ip" -- tic -x -

# 3. System update and install podman dependencies
ssh cc@"$ip" 'sudo apt update && sudo apt upgrade -y && sudo apt install -y uidmap'

# 4. Install Nix
ssh cc@"$ip" 'curl --proto "=https" --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm'
```

## Quick Reference

| Task | Command |
|------|---------|
| List hosts | `blazar host-list` |
| Show host details | `blazar host-show <id>` |
| List allocations | `blazar allocation-list host` |
| Create lease | `blazar lease-create --reservation "..." --end-date "..." <name>` |
| Show lease | `blazar lease-show <name>` |
| List leases | `blazar lease-list` |
| Extend lease | `blazar lease-update --prolong-for "1d" <name>` |
| Delete lease | `blazar lease-delete <name>` |
| List servers | `openstack server list` |
| Delete server | `openstack server delete <name>` |
| List keypairs | `openstack keypair list` |
| List networks | `openstack network list` |
| List images | `openstack image list` |

## Extend a Lease

Duration suffixes: `w` (weeks), `d` (days), `h` (hours).

```bash
blazar lease-update --prolong-for "2d" my-lease
```

## Common Mistakes

- Confusing **lease ID** with **reservation ID** — extract with `jaq` from `lease-show`
- Forgetting `--hint reservation=<id>` for `server create`
- Using wrong floating IPs — always filter by `reservation:<id>` tag
- Using `--flavor` other than `baremetal` for physical hosts
- Using `openstack reservation` commands — they don't exist; use `blazar` CLI
