/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { SINGLE_END as SINGLE_END } from '../subworkflows/SINGLE_END.nf'
include { SPIKE_IN_REMOVAL         } from '../modules/spike_in_removal'


workflow ELEMENT_CLEANUP_SE {
    take:
        fastqs_short_raw      //    channel: [val(sample), file(fastq)]
        ch_spike_in_bt2       //    path to pre-built Bowtie2 index directory (value channel)

    main:
        SINGLE_END(fastqs_short_raw)


        if (params.run_spike_in) {
            SPIKE_IN_REMOVAL(SINGLE_END.out.clean_fqs, ch_spike_in_bt2)
        }
}