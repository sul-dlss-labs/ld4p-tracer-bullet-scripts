#!/bin/bash

SCRIPT_PATH=$( cd $(dirname $0) && pwd -P )
export LD4P_ROOT=$( cd "${SCRIPT_PATH}/.." && pwd -P )
export LD4P_CONFIG="${LD4P_ROOT}/config/config.sh"
source ${LD4P_CONFIG}
export LD4P_CONFIG_BLAZEGRAPH="${LD4P_ROOT}/config/config_blazegraph.sh"
source ${LD4P_CONFIG_BLAZEGRAPH}

SPARQL_SCRIPT="${LD4P_ROOT}/bin/blazegraph_sparql_update.sh"

# ---
# Check the configuration

if [ ! -d "${LD4P_MARCRDF}" ]; then
    echo "LD4P_MARCRDF path is not a directory: ${LD4P_MARCRDF}"
    echo "Check the $LD4P_CONFIG"
    exit 1
fi

if [ -z "${LD4P_BG}" ]; then
    echo "LD4P_BG is undefined."
    echo "Check the $LD4P_CONFIG_BLAZEGRAPH"
    exit 1
fi

if [ -z "${LD4P_GRAPH}" ]; then
    echo "LD4P_GRAPH is undefined."
    echo "Check the $LD4P_CONFIG_BLAZEGRAPH"
    exit 1
fi

# ---
# Help

if [ "$1" == '-h' -o "$1" == '--help' ]; then
    cat <<HERE
Usage:
$0 > log/blazegraph_load.log 2>&1

NOTES:
  - this script must be run on a system able to connect to a blazegraph SPARQL endpoint
  - this script calls:
    - ${LD4P_CONFIG}
    - ${LD4P_CONFIG_BLAZEGRAPH}
    - ${SPARQL_SCRIPT}

HERE
    exit
fi

# ---
# Load data

echo "Blazegraph loading MARC-RDF files ${LD4P_MARCRDF}/*.rdf into graph: ${LD4P_GRAPH}"
find ${LD4P_MARCRDF} -type f -name '*.rdf' -exec ${SPARQL_SCRIPT} ${LD4P_BG} ${LD4P_GRAPH} {} \;

# TODO: investigate optimal ways to load the triples into blazegraph.
#
#      At present, this script will iterate on the RDF files and submit them
#      to blazegraph one-by-one.  There are better ways to load all the files,
#      depending on the performance of blazegraph.  Although it may not be the
#      greatest performance, loading them one-by-one has worked.
