#!/usr/bin/env bash

# @describe AFL++ wrapper
# @flag -l --local run in local mode
# @option -n --name container name
# @arg cmd~ command to run

AFL_VERSION="${AFL_VERSION:-"stable"}"

_aflpp_cmd() {
	local img="aflplusplus/aflplusplus:$AFL_VERSION"
	podman run -it --privileged --rm -v $PWD:/codebase "$image" -w /codebase "$argc_cmd[@]"
}

if [[ $argc_local ]]; then
	echo "Running in local mode"
	exit 1
else
	echo "Running AFL++ in podman mode"
	_aflpp_cmd
fi

eval "$(argc --argc-eval "$0" "$@")"
