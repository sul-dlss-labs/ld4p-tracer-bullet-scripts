#!/bin/bash
# Configure the LD4P-tracer-bullet scripts
#
# This configuration script is designed to be used like so:
# source ./ld4p_configure.sh
#
# If any custom LD4P_* paths are required, they can be set in the
# system ENV or on the command line, like so:
# LD4P_SIRSI=/ld4p_data LD4P_RDF=/ld4p_rdf source /path/to/ld4p_configure.sh

export LD4P_BASEURI="http://linked-data-test.stanford.edu/library/"

# An LD4P_ROOT path must be defined by any sripts calling this configuration.
if [ "$LD4P_ROOT" == "" ]; then
    echo "ERROR: The LD4P configuration requires an LD4P_ROOT path: ${LD4P_ROOT}" 1>&2
    kill -INT $$
fi

# Paths for code, configs and logs
export LD4P_BIN="${LD4P_ROOT}/bin"
export LD4P_LIB="${LD4P_ROOT}/lib"
export LD4P_LOGS="${LD4P_ROOT}/log"
export LD4P_CONFIGS="${LD4P_ROOT}/config"
# Check paths exist, fail if they do not
[[ ! -d "$LD4P_BIN" ]] && echo "ERROR: LD4P_BIN (${LD4P_BIN}) does not exist" && kill -INT $$
[[ ! -d "$LD4P_LIB" ]] && echo "ERROR: LD4P_LIB (${LD4P_LIB}) does not exist" && kill -INT $$
[[ ! -d "$LD4P_LOGS" ]] && echo "ERROR: LD4P_LOGS (${LD4P_LOGS}) does not exist" && kill -INT $$
[[ ! -d "$LD4P_CONFIGS" ]] && echo "ERROR: LD4P_CONFIGS (${LD4P_CONFIGS}) does not exist" && kill -INT $$

# If the system already defines an LD4P_DATA path, it will be used.
# If a custom LD4P_DATA path is required, it can be set in the
# system ENV or on the command line, like so:
# LD4P_DATA=/ld4p_data source /path/to/ld4p_configure.sh
if [ "$LD4P_DATA" == "" ]; then
    export LD4P_DATA="${LD4P_ROOT}/data"
fi
if [ ! -d "$LD4P_DATA" ]; then
    echo "ERROR: The LD4P scripts require an LD4P_DATA path: ${LD4P_DATA}" 1>&2
    kill -INT $$
fi

# If the system already defines an LD4P_RDF path, it will be used.
# If a custom LD4P_RDF path is required, it can be set in the
# system ENV or on the command line, like so:
# LD4P_RDF=/ld4p_data source /path/to/ld4p_configure.sh
if [ "$LD4P_RDF" == "" ]; then
    export LD4P_RDF="${LD4P_DATA}/rdf"
fi
if [ ! -d "$LD4P_RDF" ]; then
    echo "ERROR: The LD4P scripts require an LD4P_RDF path: ${LD4P_RDF}" 1>&2
    kill -INT $$
fi

# Paths for data records
export LD4P_MARC="${LD4P_DATA}/Marc"
export LD4P_MARCXML="${LD4P_DATA}/MarcXML"
export LD4P_MARCRDF="${LD4P_RDF}/MarcRDF"
# Create paths, recursively, if they don't exist
mkdir -p ${LD4P_DATA} || kill -INT $$
mkdir -p ${LD4P_MARC} || kill -INT $$
mkdir -p ${LD4P_MARCXML} || kill -INT $$
mkdir -p ${LD4P_MARCRDF} || kill -INT $$

# Paths to archive processed records
export LD4P_ARCHIVE_MARC="${LD4P_DATA}/Archive/Marc"
export LD4P_ARCHIVE_MARCXML="${LD4P_DATA}/Archive/MarcXML"
export LD4P_ARCHIVE_MARCRDF="${LD4P_DATA}/Archive/MarcRDF"
# Create paths, recursively, if they don't exist
mkdir -p ${LD4P_ARCHIVE_MARC} || kill -INT $$
mkdir -p ${LD4P_ARCHIVE_MARCXML} || kill -INT $$
mkdir -p ${LD4P_ARCHIVE_MARCRDF} || kill -INT $$

# Record processing options (toggles):
# Toggle to archive processed records
export LD4P_ARCHIVE_ENABLED=true
# Toggle to replace existing MARC-XML files; note that when MARC binary files
# have a timestamp later than a MARC-XML file, the XML file will be replaced.
export LD4P_MARCXML_REPLACE=false
# Toggle to replace existing MARC-RDF files; note that when MARC-XML files
# have a timestamp later than a MARC-RDF file, the RDF file will be replaced.
export LD4P_MARCRDF_REPLACE=false

# Paths for libraries
export LD4P_JAR="${LD4P_BIN}/ld4p_converter.jar"


