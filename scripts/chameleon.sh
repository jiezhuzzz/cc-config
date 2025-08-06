#!/usr/bin/env bash

# @describe script for chameleon cloud
# @env OS_PASSWORD! password for openstack

export OS_AUTH_URL="https://chi.uc.chameleoncloud.org:5000/v3"
export OS_IDENTITY_API_VERSION="3"
export OS_INTERFACE="public"
export OS_PROJECT_ID="808c50b3f1ae447e9fc1d6a5a03c2b66"
export OS_USERNAME="jiezhu@uchicago.edu"
export OS_PROTOCOL="openid"
export OS_AUTH_TYPE="v3oidcpassword"
export OS_IDENTITY_PROVIDER="chameleon"
export OS_DISCOVERY_ENDPOINT="https://auth.chameleoncloud.org/auth/realms/chameleon/.well-known/openid-configuration"
export OS_CLIENT_ID="keystone-uc-prod"
export OS_ACCESS_TOKEN_TYPE="access_token"
export OS_CLIENT_SECRET="none"
export OS_REGION_NAME="CHI@UC"

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
    local utc_end_date=$(TZ=UTC date -d "+$argc_duration days" +"%Y-%m-%d %H:00")
    # create baremetal reservation
    blazar lease-create --reservation min=$argc_nodes,max=$argc_nodes,resource_type=physical:host,resource_properties="[\"=\", \"\$node_type\", \"$argc_type\"]" --end-date "$utc_end_date" "$argc_name"
    # create floating ip reservation
    local public_ip=$(openstack network show public -c id -f value)
    blazar lease-create --reservation resource_type=virtual:floatingip,network_id=${public_ip},amount=$argc_nodes --end-date "$utc_end_date" "$argc_name"
}

# @cmd bind instances to a lease
# @option -i --image[=CC-Ubuntu24.04|CC-Ubuntu22.04] image name
# @arg lease! lease name
# @arg name! instance name
instance-create() {
    local reservation_id=$(blazar lease-show -c reservations -f json "$argc_lease" | jq -r '.reservations | fromjson | .id')
    local sharednet_id=$(openstack network show sharednet1 -c id -f value)
    openstack server create --image "$argc_image" --flavor baremetal --key-name 1password --nic net-id="$sharednet_id" --hint reservation="$reservation_id" "$argc_name"
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