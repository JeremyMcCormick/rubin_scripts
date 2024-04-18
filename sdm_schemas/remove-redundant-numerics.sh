#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $(basename $0) <schema1> <schema2> ..."
    exit 1
fi

for sch in "$@"; do
    echo "Processing $sch ..."
    cat $sch | awk -f "$(dirname "$0")/remove-redundant-numerics.awk" &> $sch.tmp
    cp $sch.tmp $sch.bak
    cp $sch.tmp $sch
    rm $sch.tmp
done
