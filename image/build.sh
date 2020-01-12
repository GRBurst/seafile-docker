#! /usr/bin/env bash
if [ -n "$2" ]; then
    echo "Building with POSTFIX=$2: make $1"
    make "$1" "POSTFIX=$2"
else
    echo "Building: make $1"
    make "$1"
fi
