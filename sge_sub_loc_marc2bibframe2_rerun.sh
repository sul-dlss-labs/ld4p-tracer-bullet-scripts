#!/bin/bash

cmd=$(keeptoken 2> /dev/null | grep 'source')
eval $cmd

source ./farmshare_config.sh

echo "Searching for empty MARC-RDF files to re-run: ${LD4P_MARCRDF}/*.rdf"
rdf_empty_files=$(find ${LD4P_MARCRDF} -type f -empty -name '*.rdf')
for rdf_file in ${rdf_empty_files}; do

    xml_file=$(echo $rdf_file | sed -e 's/.*MarcRDF.//' -e 's/.rdf/.xml/')
    xml_file="${LD4P_MARCXML}/$xml_file"
    echo "Submitting job to process: ${xml_file}"
    qsub sge_run_loc_marc2bibframe2.sh ${xml_file}
done

