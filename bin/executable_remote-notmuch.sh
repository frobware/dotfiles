#!/usr/bin/env bash

printf -v ARGS "%q " "$@"
exec ssh notmuch notmuch ${ARGS}
