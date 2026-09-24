#!/usr/bin/env bash
# GVariant single-quoted strings treat ' and \ as syntax. Escape both
# before the value is placed in the method argument.
escaped=$(printf '%s' "${1-}" | sed "s/\\\\/\\\\\\\\/g; s/'/\\\\'/g")
gdbus call --session --dest io.appflowy.AppFlowy \
    --object-path /io/appflowy/AppFlowy/Object \
    --method io.appflowy.AppFlowy.Open "['${escaped}']" {}
