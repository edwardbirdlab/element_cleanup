/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { PAIRED_END as PAIRED_END } from '../subworkflows/PAIRED_END.nf'


workflow ELEMENT_CLEANUP_PE {
    take:
        fastqs_short_raw      //    channel: [val(sample), file(fastq), file(fastq)]

    main:
        PAIRED_END(fastqs_short_raw)

}