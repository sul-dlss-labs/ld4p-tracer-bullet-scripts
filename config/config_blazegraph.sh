#!/bin/bash
# Default configuration for the LD4P blazegraph scripts
#
# This configuration script is designed to be called like so:
# source ./config_blazegraph.sh

if [ "$LD4P_BG" == "" ]; then
    # Defaults to the Blazegraph-DEV box
    export LD4P_BG='http://sul-ld4p-blazegraph-dev.stanford.edu/blazegraph'
fi

if [ "$LD4P_GRAPH" == "" ]; then
    export LD4P_GRAPH='ld4p'
fi

