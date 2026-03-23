/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { SINGLE_END as SINGLE_END } from '../subworkflows/SINGLE_END.nf'
include { HOST_REMOVAL_SE          } from '../modules/HOST_REMOVAL_SE'


workflow ELEMENT_CLEANUP_SE {
    take:
        fastqs_short_raw      //    channel: [val(sample), file(fastq)]
        ch_bt2_index          //    path to pre-built Bowtie2 index directory (value channel)
    main:
        SINGLE_END(fastqs_short_raw)


        if (params.run_host_removal) {
            SPIKE_IN_REMOVAL(SINGLE_END.out.clean_fqs, ch_bt2_index)
        }
}