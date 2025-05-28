#! /usr/bin/env bash
aflpp() {
    AFL_VERSION="${AFL_VERSION:-"stable"}"
    case "$1" in
        host)
            shift
            bash -c "$*"
            ;;
        podman)
            shift
            /usr/bin/env podman run -ti \
                --privileged \
                -v ./:/src \
                --rm \
                --name afl_fuzzing \
                "aflplusplus/aflplusplus:$AFL_VERSION" \
                bash -c "cd /src && bash -c \"$*\""
            ;;
        *)
            echo "Usage: aflpp {host|podman}"
            return 1
            ;;
    esac
}
