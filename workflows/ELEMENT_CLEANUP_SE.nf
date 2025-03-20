/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { SINGLE_END as SINGLE_END } from '../subworkflows/SINGLE_END.nf'


workflow ELEMENT_CLEANUP_SE {
    take:
        fastqs_short_raw      //    channel: [val(sample), file(fastq)]

    main:
        SINGLE_END(fastqs_short_raw)

}