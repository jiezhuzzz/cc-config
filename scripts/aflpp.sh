#!/usr/bin/env bash

# @description "AFL++ wrapper"
# @flag -l --local "Run in local mode"
# @option -n --name "Container name"
# @arg cmd~ "Command to run"

eval "$(argc --argc-eval "$0" "$@")"

AFL_VERSION="${AFL_VERSION:-"stable"}"

_aflpp_cmd() {
    local img="aflplusplus/aflplusplus:$AFL_VERSION"
    podman run -it --privileged --rm -v $PWD:/codebase "$image" -w /codebase "$argc_cmd[@]"
}

if [[ $argc_local ]]; then
    error "Running in local mode"
    return 1
else
    echo "Running AFL++ in podman mode"
    _aflpp_cmd
fi