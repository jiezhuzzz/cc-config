#!/usr/bin/env bash

# @describe script for chameleon cloud
# @env OS_PASSWORD! password for openstack

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

# @cmd blazar client
blazar() {
    uvx --from python-blazarclient blazar "$@"
}

# @cmd openstack client
openstack() {
    uvx --from python-openstackclient openstack "$@"
}

# @cmd create a lease
# @option -n --nodes=1 number of nodes
# @option -t --type[=compute_cascadelake_r|compute_skylake] node type
# @option -d --duration=7 duration of the lease (days)
# @arg name! lease name
lease-create() {
    if date -d "now" >/dev/null 2>&1; then
        local utc_end_date=$(TZ=UTC date -d "+${argc_duration} days" +"%Y-%m-%d %H:00")
    else
        local utc_end_date=$(TZ=UTC date -v+"${argc_duration}"d +"%Y-%m-%d %H:00")
    fi
    local public_ip=$(openstack network show public -c id -f value)
    blazar lease-create \
        --reservation "min=$argc_nodes,max=$argc_nodes,resource_type=physical:host,resource_properties=[\"=\",\"\$node_type\",\"$argc_type\"]" \
        --reservation "resource_type=virtual:floatingip,network_id=${public_ip},amount=$argc_nodes" \
        --end-date "$utc_end_date" "$argc_name" 2>/dev/null
}

# @cmd bind instances to a lease
# @option -i --image[=CC-Ubuntu24.04|CC-Ubuntu22.04] image name
# @arg lease! lease name
# @arg name! instance name
instance-create() {
    local reservation_id=$(blazar lease-show -c reservations -f json "$argc_lease" | jq -r '.reservations' | jq -r 'select(.resource_type == "physical:host") | .id')
    local sharednet_id=$(openstack network show sharednet1 -c id -f value)
    openstack server create --image "$argc_image" --flavor baremetal --key-name 1password --nic net-id="$sharednet_id" --hint reservation="$reservation_id" "$argc_name"
    mapfile -t free_floating_ip < <(openstack floating ip list -f json | jq -r '.[] | select(.["Fixed IP Address"] == null) | .["Floating IP Address"]')
    openstack server add floating ip "$argc_name" "${free_floating_ip[0]}"
}

# @cmd end-to-end create a lease and instances
# @option -n --nodes=1 number of nodes
# @option -t --type[=compute_cascadelake_r|compute_skylake] node type
# @option -i --image[=CC-Ubuntu24.04|CC-Ubuntu22.04] image name
# @option -d --duration=7 duration of the lease (days)
# @arg name! lease name
e2e-create() {
    # create lease
    if date -d "now" >/dev/null 2>&1; then
        local utc_end_date=$(TZ=UTC date -d "+${argc_duration} days" +"%Y-%m-%d %H:00")
    else
        local utc_end_date=$(TZ=UTC date -v+"${argc_duration}"d +"%Y-%m-%d %H:00")
    fi

    # get current available floating IPs
    mapfile -t previous_floating_ip < <(openstack floating ip list -f json | jq -r '.[] | select(.["Fixed IP Address"] == null) | .["Floating IP Address"]')

    local public_ip=$(openstack network show public -c id -f value)
    local physical_reservation_id=$(blazar lease-create \
        -f json \
        --reservation "min=$argc_nodes,max=$argc_nodes,resource_type=physical:host,resource_properties=[\"=\",\"\$node_type\",\"$argc_type\"]" \
        --reservation "resource_type=virtual:floatingip,network_id=${public_ip},amount=$argc_nodes" \
        --end-date "$utc_end_date" \
        "$argc_name" 2>/dev/null | tail -n +2 | jq -r '.reservations' | jq -r 'select(.resource_type == "physical:host") | .id')

    # wait for lease to be created
    sleep 15

    # get allocated floating IPs
    mapfile -t current_floating_ip < <(openstack floating ip list -f json | jq -r '.[] | select(.["Fixed IP Address"] == null) | .["Floating IP Address"]')

    # Find newly allocated floating IPs (IPs in current but not in previous)
    local available_floating_ips=()
    for ip in "${current_floating_ip[@]}"; do
        local found=0
        for prev_ip in "${previous_floating_ip[@]}"; do
            if [[ "$ip" == "$prev_ip" ]]; then
                found=1
                break
            fi
        done
        if [[ $found -eq 0 ]]; then
            available_floating_ips+=("$ip")
        fi
    done

    echo "Available Floating IPs: ${available_floating_ips[@]}"

    local sharednet_id=$(openstack network show sharednet1 -c id -f value)
    for i in $(seq 1 $argc_nodes); do
        openstack server create \
            --image "$argc_image" \
            --flavor baremetal \
            --key-name 1password \
            --nic net-id="$sharednet_id" \
            --hint reservation="$physical_reservation_id" \
            --wait \
            "$argc_name-$i"
        openstack server add floating ip "$argc_name-$i" "${available_floating_ips[$(($i - 1))]}"
    done
}

# @cmd extend a lease
# @arg name! lease name
lease-extend() {
    blazar lease-update --prolong-for "7d" "$argc_name"
}

# @cmd list all leases
lease-list() {
    blazar lease-list
}

eval "$(argc --argc-eval "$0" "$@")"
