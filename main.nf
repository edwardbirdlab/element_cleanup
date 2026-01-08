#!/usr/bin/env nextflow
                                  


/*
========================================================================================
                         edwardbirdlab/element_cleanup
========================================================================================
 Pipline to clean up short read data generated on the Aviti Element
 #### Find information at:
https://github.com/edwardbirdlab/element_cleanup
----------------------------------------------------------------------------------------
*/
nextflow.enable.dsl=2

if (params.workflow_opt == 'cleanup_pe') {

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.r1), file(row.r2)) }

    }

if (params.workflow_opt == 'cleanup_se') {

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.r1)) }

    }

include { ELEMENT_CLEANUP_SE as ELEMENT_CLEANUP_SE } from './workflows/ELEMENT_CLEANUP_SE.nf'
include { ELEMENT_CLEANUP_PE as ELEMENT_CLEANUP_PE } from './workflows/ELEMENT_CLEANUP_PE.nf'
include { MULTIQC as MULTIQC } from './workflows/MULTIQC.nf'

workflow {

    if (params.workflow_opt == 'cleansup_se') {

        ELEMENT_CLEANUP_SE(ch_fastq)

        }

    if (params.workflow_opt == 'cleanup_pe') {

        ELEMENT_CLEANUP_PE(ch_fastq)

        }

    if (params.workflow_opt == 'multiqc') {

        MULTIQC()

        }
}