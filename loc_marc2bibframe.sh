# vim: autoindent tabstop=4 shiftwidth=4 expandtab softtabstop=4 filetype=sh
#!/bin/bash

SCRIPT_PATH=$(dirname $0)

# Check dependencies
if [ "$LOC_M2B_XQUERY" == "" ]; then
    source ${SCRIPT_PATH}/ld4p_configure.sh
fi

# Bash function to convert one MARC-XML file to a Bibframe RDF file.
# Depends on the environment variables defined in ld4p_configure.sh
# Depends on installation of the loc marc2bibframe project.
# Usage:  loc_marc2bibframe {MRC_XML} {MRC_RDF}
loc_marc2bibframe () {
    MRC_XML=$1
    MRC_RDF=$2

    filename=$(basename "${MRC_XML}" ".xml")
    MRC_RDF="${LD4P_MARCRDF}/${filename}.rdf"

    if [[ "${LD4P_MARCRDF_REPLACE}" == "" && -s "${MRC_RDF}" ]]; then
        echo "Skipping existing MARC-RDF file: ${MRC_RDF}" >> ${LOG_FILE}
        return 0
    fi

#    export LOC_M2B_XQUERY="${LD4P_BIN}/loc_marc2bibframe.xqy"
#    m2b_xquery=${LD4P_BIN}/Marc2Bibframe/marc2bibframe/xbin/saxon.xqy
    java -cp ${LD4P_JAR} \
        net.sf.saxon.Query ${LOC_M2B_XQUERY} \
            marcxmluri="file://${MRC_XML}" \
            baseuri=${LD4P_BASEURI} \
            serialization="rdfxml" \
            1> ${MRC_RDF} \
            2>> ${LOG_FILE}

    SUCCESS=$?
    if [ ${SUCCESS} ]; then
        echo "Converted MARC-RDF file: ${MRC_RDF}" >> ${LOG_FILE}
        mv ${MRC_XML} ${LD4P_ARCHIVE_MARCXML}
    else
        echo "ERROR: Conversion failed for ${MRC_XML}" >> ${LOG_FILE}
    fi

    return ${SUCCESS}
}

