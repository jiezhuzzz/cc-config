#!/usr/bin/env bash

# @describe multiplier wrapper

MX_VERSION="${MX_VERSION:-"stable"}"
IMG="docker.io/jiezhuzzz/multiplier:$MX_VERSION"

# @cmd build multiplier database
# @flag -i --interactive run in interactive mode
# @option -n --name container name
# @arg dst! target directory
build() {
	local name="${argc_name:-"mx-$(basename $PWD)"}"
	local dst="${argc_dst:-"$PWD"}"
	if [[ -n $argc_interactive ]]; then
		podman run --cpus=4 -it --rm -v "$(realpath "$dst")":/codebase --name "$name" -w /codebase --entrypoint /bin/bash "$IMG"
	else
		podman run --cpus=4 --rm -v "$(realpath "$dst")":/codebase --name "$name" -w /codebase --entrypoint /codebase/mx-build.sh "$IMG"
	fi
}

# @cmd run multiplier
# @flag -i --interactive run in interactive mode
# @arg cmd~ command to run
run() {
	if [[ -n $argc_interactive ]]; then
		podman run -it --rm -v "$PWD":/codebase -w /codebase "$IMG" /bin/bash
	else
		podman run --rm -v "$PWD":/codebase -w /codebase "$IMG" "${argc_cmd[@]}"
	fi
}

eval "$(argc --argc-eval "$0" "$@")"
