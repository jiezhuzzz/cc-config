#!/usr/bin/env bash

# @describe multiplier wrapper

MX_VERSION="${MX_VERSION:-"stable"}"
IMG="docker.io/jiezhuzzz/multiplier:$MX_VERSION"

# @cmd build multiplier database
# @option -n --name container name
# @option -c --cpus number of cpus to use
# @arg dst! target directory
build() {
	local name="${argc_name:-"mx-$(basename $PWD)"}"
	local dst="${argc_dst:-"$PWD"}"
	local cpus="${argc_cpus:-$(($(nproc) / 8))}"
	podman run --cpus="$cpus" -it --rm -v "$(realpath "$dst")":/codebase --name "$name" -w /codebase --entrypoint /bin/bash "$IMG"
}

_mx_cmd() {
	local img="ghcr.io/mxschmitt/multiplier:$MX_VERSION"
	podman run -it --privileged --rm -v $PWD:/codebase "$image" -w /codebase "$argc_cmd[@]"
}

eval "$(argc --argc-eval "$0" "$@")"
