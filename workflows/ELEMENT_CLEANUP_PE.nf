/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { PAIRED_END as PAIRED_END } from '../subworkflows/PAIRED_END.nf'
include { HOST_REMOVAL_PE          } from '../modules/HOST_REMOVAL_PE'


workflow ELEMENT_CLEANUP_PE {
    take:
        fastqs_short_raw      //    channel: [val(sample), file(fastq), file(fastq)]
        ch_bt2_index          //    path to pre-built Bowtie2 index directory (value channel)

    main:
        PAIRED_END(fastqs_short_raw)

        if (params.run_host_removal) {
            HOST_REMOVAL_PE(PAIRED_END.out.clean_fqs, ch_bt2_index)
        }
}